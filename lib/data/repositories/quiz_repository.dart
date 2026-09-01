import 'dart:developer' as developer;
import '../../core/models/question_model.dart';
import '../../core/models/subject_enum.dart';
import '../../core/models/difficulty_enum.dart';
import '../../core/services/gemini_ai_service.dart';
import '../datasources/curriculum_datasource.dart';

class QuizRepository {
  final GeminiAIService _aiService;

  QuizRepository(this._aiService);

  /// Loads 20 tailored quiz questions using Gemini AI first, with seamless fallback
  Future<List<QuizQuestion>> getQuizQuestions({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    int count = 20,
  }) async {
    try {
      developer.log('QuizRepository: Requesting Gemini AI questions for Grade $grade ${subject.displayName} ($difficulty)...');
      final aiQuestions = await _aiService.generateQuestions(
        subject: subject,
        grade: grade,
        difficulty: difficulty,
        count: count,
      );
      if (aiQuestions.isNotEmpty) {
        return aiQuestions;
      }
    } catch (e) {
      developer.log('QuizRepository: AI generation fallback triggered: $e');
    }

    // Fallback to high-quality authentic K-12 curriculum database
    return CurriculumDataSource.getQuestions(
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      count: count,
    );
  }
}
