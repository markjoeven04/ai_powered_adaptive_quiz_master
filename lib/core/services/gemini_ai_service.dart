import 'dart:convert';
import 'dart:developer' as developer;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/env_config.dart';
import '../models/question_model.dart';
import '../models/subject_enum.dart';
import '../models/difficulty_enum.dart';
import 'storage_service.dart';

class GeminiAIService {
  final StorageService? _storageService;

  GeminiAIService([this._storageService]);

  List<String> _getAvailableKeys() {
    final keys = <String>[];

    // 1. Highest Priority: Custom user-provided keys saved locally on device
    final customPrimary = _storageService?.getCustomApiKey()?.trim();
    if (customPrimary != null && customPrimary.isNotEmpty) {
      keys.add(customPrimary);
    }
    final customBackup = _storageService?.getCustomBackupApiKey()?.trim();
    if (customBackup != null && customBackup.isNotEmpty) {
      keys.add(customBackup);
    }

    // 2. Secret environment configuration (git-ignored)
    if (EnvConfig.geminiApiKey.isNotEmpty && !keys.contains(EnvConfig.geminiApiKey)) {
      keys.add(EnvConfig.geminiApiKey);
    }
    if (EnvConfig.geminiBackupApiKey.isNotEmpty && !keys.contains(EnvConfig.geminiBackupApiKey)) {
      keys.add(EnvConfig.geminiBackupApiKey);
    }

    return keys;
  }

  /// Generates a complete set of [count] adaptive multiple-choice questions via Gemini
  Future<List<QuizQuestion>> generateQuestions({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    int count = 20,
  }) async {
    final keys = _getAvailableKeys();
    Exception? lastError;

    for (final apiKey in keys) {
      if (apiKey.isEmpty) continue;
      try {
        developer.log('Attempting AI question generation with key ending in ...${apiKey.length > 6 ? apiKey.substring(apiKey.length - 4) : apiKey}');
        final questions = await _callGeminiWithKey(
          apiKey: apiKey,
          subject: subject,
          grade: grade,
          difficulty: difficulty,
          count: count,
        );
        if (questions.isNotEmpty) {
          developer.log('Successfully generated ${questions.length} questions from Gemini AI!');
          return questions;
        }
      } catch (e, st) {
        developer.log('Gemini API attempt failed with key: $e', error: e, stackTrace: st);
        lastError = Exception(e.toString());
      }
    }

    throw lastError ?? Exception('Failed to generate questions from AI services.');
  }

  Future<List<QuizQuestion>> _callGeminiWithKey({
    required String apiKey,
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    required int count,
  }) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        responseMimeType: 'application/json',
      ),
    );

    final prompt = '''
You are an expert curriculum designer and educator specializing in the Philippine K-12 Basic Education Curriculum for Grade $grade.
Create a comprehensive, engaging self-review quiz of exactly $count multiple-choice questions for the following specifications:

- Subject: ${subject.displayName}
- Grade Level: Grade $grade (Philippine K-12 standard)
- Difficulty Level: ${difficulty.title} (${difficulty.subtitle})

Requirements for each question:
1. "prompt": Clear, age-appropriate question statement for Grade $grade.
2. "options": Exactly 4 distinct multiple-choice options (A, B, C, D) as strings.
3. "correct_index": The 0-based integer index of the correct option (0, 1, 2, or 3).
4. "explanation": A thorough, supportive educational explanation stating why the correct answer is right and why it matters.
5. "keyword": A specific 1-2 word visual noun directly representing the exact core concept of the question (e.g. "volcano", "photosynthesis", "fraction", "triangle", "heart", "jose rizal", "katipunan", "gravity", "butterfly", "reading", "circuits", "dna", "telescope", "algebra", "weather").

Return the output as a valid JSON array of question objects:
[
  {
    "prompt": "...",
    "options": ["A", "B", "C", "D"],
    "correct_index": 0,
    "explanation": "...",
    "keyword": "..."
  }
]
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final responseText = response.text;

    if (responseText == null || responseText.trim().isEmpty) {
      throw Exception('Empty response received from Gemini.');
    }

    final cleanedJson = _cleanJsonString(responseText);
    final decoded = jsonDecode(cleanedJson);

    final List<dynamic> list;
    if (decoded is List) {
      list = decoded;
    } else if (decoded is Map && decoded.containsKey('questions')) {
      list = decoded['questions'] as List;
    } else {
      throw Exception('Unexpected JSON format received from AI model');
    }

    final results = <QuizQuestion>[];
    for (int i = 0; i < list.length; i++) {
      final item = list[i] as Map<String, dynamic>;
      final rawOptions = item['options'] as List<dynamic>? ?? [];
      final options = rawOptions.map((o) => o.toString().trim()).toList();
      if (options.length < 4) {
        while (options.length < 4) {
          options.add('Option ${options.length + 1}');
        }
      }

      final correctIndex = (item['correct_index'] as num?)?.toInt() ??
          (item['correctIndex'] as num?)?.toInt() ??
          0;

      results.add(QuizQuestion(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}_$i',
        prompt: item['prompt']?.toString().trim() ?? 'Question ${i + 1}',
        options: options.sublist(0, 4),
        correctIndex: (correctIndex >= 0 && correctIndex < 4) ? correctIndex : 0,
        explanation: item['explanation']?.toString().trim() ?? 'Review this concept carefully.',
        imageKeyword: item['keyword']?.toString().trim(),
        subject: subject.displayName,
        grade: grade,
        difficulty: difficulty.id,
      ));
    }

    return results;
  }

  String _cleanJsonString(String raw) {
    String text = raw.trim();
    if (text.startsWith('```json')) {
      text = text.substring(7);
    } else if (text.startsWith('```')) {
      text = text.substring(3);
    }
    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }
    return text.trim();
  }
}
