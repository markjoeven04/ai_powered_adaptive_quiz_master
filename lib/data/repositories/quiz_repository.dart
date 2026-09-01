import 'dart:developer' as developer;
import '../../core/models/question_model.dart';
import '../../core/models/subject_enum.dart';
import '../../core/models/difficulty_enum.dart';
import '../../core/services/gemini_ai_service.dart';
import '../datasources/curriculum_datasource.dart';

class QuizRepository {
  final GeminiAIService _aiService;

  QuizRepository(this._aiService);

  /// Generates 20 pure dynamic questions strictly from Gemini AI
  /// Never falls back silently to local data. Throws if offline/failed.
  Future<List<QuizQuestion>> getAiQuizQuestions({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    int count = 20,
  }) async {
    developer.log('QuizRepository: Requesting 100% Pure Gemini AI questions...');
    final aiQuestions = await _aiService.generateQuestions(
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      count: count,
    );

    if (aiQuestions.isNotEmpty) {
      return aiQuestions;
    }

    throw Exception('No questions returned by Gemini AI.');
  }

  /// Explicitly loads 20 questions from the official DepEd Curriculum Bank
  /// Only called when the user confirms they want to practice offline.
  List<QuizQuestion> getDepEdCurriculumQuestions({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    int count = 20,
  }) {
    developer.log('QuizRepository: Loading questions from DepEd Curriculum Bank...');
    return CurriculumDataSource.getQuestions(
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      count: count,
    );
  }
}
