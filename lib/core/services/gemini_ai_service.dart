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
    if (EnvConfig.geminiKey3.isNotEmpty && !keys.contains(EnvConfig.geminiKey3)) {
      keys.add(EnvConfig.geminiKey3);
    }
    if (EnvConfig.geminiKey4.isNotEmpty && !keys.contains(EnvConfig.geminiKey4)) {
      keys.add(EnvConfig.geminiKey4);
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
    if (keys.isEmpty) {
      throw Exception('No Gemini API keys configured.');
    }

    Exception? lastError;

    for (int i = 0; i < keys.length; i++) {
      final apiKey = keys[i];
      if (apiKey.isEmpty) continue;
      final keyLabel = 'Key #${i + 1} (...${apiKey.length > 6 ? apiKey.substring(apiKey.length - 4) : apiKey})';
      try {
        developer.log('Attempting AI generation with $keyLabel');
        final questions = await _callGeminiWithKey(
          apiKey: apiKey,
          subject: subject,
          grade: grade,
          difficulty: difficulty,
          count: count,
        );
        if (questions.isNotEmpty) {
          developer.log('Successfully generated ${questions.length} questions using $keyLabel!');
          return questions;
        }
      } catch (e, st) {
        developer.log('Gemini attempt failed for $keyLabel: $e', error: e, stackTrace: st);
        lastError = Exception('$keyLabel error: $e');
        // If Key #1 hits rate limit / quota exceeded / error, automatically tries Key #2
      }
    }

    throw lastError ?? Exception('Failed to generate questions. Both primary and backup API keys failed.');
  }

  Future<List<QuizQuestion>> _callGeminiWithKey({
    required String apiKey,
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    required int count,
  }) async {
    final sessionSeed = DateTime.now().millisecondsSinceEpoch % 100000;

    final model = GenerativeModel(
      model: 'gemini-3.6-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.8,
        responseMimeType: 'application/json',
      ),
    );


    final guideline = _getGradeLevelCurriculumGuideline(grade, subject, difficulty);

    final prompt = '''
You are an expert curriculum developer specializing in the Philippine Department of Education (DepEd) K-12 Basic Education Curriculum.
Generate a dynamic, non-repetitive, high-engagement set of exactly $count multiple-choice questions for:

- Subject: ${subject.displayName}
- Grade Level: Grade $grade (Target Age: ${grade + 5} to ${grade + 6} years old)
- Difficulty Tier: ${difficulty.title} (${difficulty.subtitle})
- Random Session Seed: #$sessionSeed

$guideline

PEDAGOGICAL & SPEED RULES:
1. VARIETY GUARANTEE: Ensure every single question tests a DIFFERENT topic/competency within Grade $grade ${subject.displayName}. Do NOT repeat questions.
2. ACCURATE DIFFICULTY: Calibrate strictly to what is taught at Grade $grade level in Philippine schools.
3. CLEAR OPTIONS: Provide 4 distinct options where only 1 is undeniably correct and 3 are plausible distractors.
4. "keyword": Provide a specific 1-2 word visual noun matching the question's core subject (e.g. "philippine flag", "jose rizal", "carabao", "plant", "heart", "triangle", "apple").
5. "explanation": Keep concise (1 punchy sentence, max 20 words) for ultra-fast generation.

Return ONLY a valid JSON array of question objects:
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


    final response = await model
        .generateContent([Content.text(prompt)])
        .timeout(const Duration(seconds: 55));
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

      final safeCorrectIndex = (correctIndex >= 0 && correctIndex < options.length) ? correctIndex : 0;
      final correctAnswerText = options[safeCorrectIndex];

      // Programmatically shuffle the 4 options so the correct answer is uniformly distributed among A, B, C, and D
      final shuffledOptions = options.sublist(0, 4)..shuffle();
      final newCorrectIndex = shuffledOptions.indexOf(correctAnswerText);

      results.add(QuizQuestion(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}_$i',
        prompt: item['prompt']?.toString().trim() ?? 'Question ${i + 1}',
        options: shuffledOptions,
        correctIndex: newCorrectIndex >= 0 ? newCorrectIndex : 0,
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

  String _getGradeLevelCurriculumGuideline(int grade, Subject subject, QuizDifficulty difficulty) {
    if (grade <= 3) {
      return '''
CRITICAL PEDAGOGICAL CALIBRATION FOR PRIMARY GRADE $grade (Ages 6-8):
- TARGET AUDIENCE: Young elementary pupil in Grade $grade.
- VOCABULARY: Must be SHORT, CLEAR, SIMPLE words that a 6-8 year old understands. No complex terminology!
- SUBJECT COMPETENCIES:
  * Science: Five senses (eyes see, ears hear, nose smells), basic body parts, animals & sounds/homes (birds fly, fish swim), living vs non-living, basic plant parts (root, stem, leaf, flower), weather (sunny, rainy), day and night. (DO NOT ask about cells, chemical symbols, taxonomy, gravity formulas, or high school science).
  * Math: Counting numbers 1-100, simple addition and subtraction (e.g. 5 + 3 = 8, 12 - 4 = 8), basic shapes (circle, triangle, square, rectangle), identifying Philippine coins/bills, telling time by the hour (e.g. 3:00). (DO NOT ask about fractions, algebra, formulas, or multi-step word problems).
  * Philippine History / Araling Panlipunan: Philippine flag colors (blue, red, white, yellow sun & stars), national symbols (carabao, mango, Philippine eagle, baro't saya), family, community helpers (teacher, doctor, nurse, firefighter, police). (DO NOT ask about historical treaties, dates, 1896 battle plans, or legislation).
  * English: Rhyming words (cat/bat), alphabet phonics, naming words (nouns), action words (verbs), simple descriptive words (colors, big/small, happy/sad), opposites (hot/cold, up/down).
- DIFFICULTY SCALING FOR ${difficulty.title}:
  * Easy: Direct visual recognition & simple recall.
  * Medium: Standard grade $grade classroom level.
  * Hard: Slight challenge (e.g. simple 1-step word problem with small numbers).
''';
    } else if (grade <= 6) {
      return '''
CRITICAL PEDAGOGICAL CALIBRATION FOR INTERMEDIATE GRADE $grade (Ages 9-11):
- TARGET AUDIENCE: Intermediate elementary pupil in Grade $grade.
- SUBJECT COMPETENCIES:
  * Science: Digestive and respiratory systems basics, plant photosynthesis basics, simple food chains, water cycle, 3 states of matter (solid, liquid, gas), simple machines, planets in the solar system, typhoon & earthquake safety.
  * Math: Multiplication & division, basic fractions (1/2, 1/4, 3/4), basic decimals, perimeter & area of rectangles/triangles, simple bar graphs, measurement conversions.
  * Philippine History: Philippine major islands (Luzon, Visayas, Mindanao), national heroes (Jose Rizal, Andres Bonifacio, Lapu-Lapu), Spanish period overview, Katipunan overview.
  * English: Parts of speech (nouns, pronouns, verbs, adjectives, adverbs), subject-verb agreement, synonyms/antonyms, compound sentences, main idea.
''';
    } else if (grade <= 10) {
      return '''
CRITICAL PEDAGOGICAL CALIBRATION FOR JUNIOR HIGH SCHOOL GRADE $grade (Ages 12-15):
- TARGET AUDIENCE: Junior high school student in Grade $grade.
- SUBJECT COMPETENCIES:
  * Science: Integrated science - cells, genetics, forces & motion, periodic table foundations, earth science, climate, ecosystems.
  * Math: Algebra (linear equations, polynomials), geometry (angles, triangles, Pythagorean theorem), coordinate plane, basic statistics & probability.
  * Philippine History: Pre-colonial barangays, Spanish colonization, 1896 Revolution, American & Japanese eras, Philippine Constitution.
  * English: Figurative language (simile, metaphor, personification), grammar & syntax, active/passive voice, reading comprehension.
''';
    } else {
      return '''
CRITICAL PEDAGOGICAL CALIBRATION FOR SENIOR HIGH SCHOOL GRADE $grade (Ages 16-18):
- TARGET AUDIENCE: Senior high school student in Grade $grade.
- Core curriculum: General Mathematics, General Biology/Chemistry/Physics, Philippine Politics and Governance, English for Academic Purposes.
''';
    }
  }
}

