import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/subject_enum.dart';
import '../../core/models/difficulty_enum.dart';
import '../../core/models/quiz_session_model.dart';
import '../../core/providers/app_providers.dart';
import '../../data/repositories/quiz_repository.dart';
import 'quiz_state.dart';

class ActiveQuizNotifier extends StateNotifier<ActiveQuizState> {
  final QuizRepository _quizRepository;
  final Ref _ref;

  ActiveQuizNotifier(this._quizRepository, this._ref)
      : super(const ActiveQuizState(
          subject: Subject.science,
          grade: 1,
          difficulty: QuizDifficulty.medium,
          studentName: '',
        ));

  /// Pure Gemini AI Generation (Default)
  Future<void> startQuiz({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    required String studentName,
  }) async {
    state = ActiveQuizState(
      isLoading: true,
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      studentName: studentName,
      currentIndex: 0,
      score: 0,
      answers: [],
      questions: [],
      isAiGenerated: true,
      isOfflineFallbackPrompt: false,
    );

    try {
      final questions = await _quizRepository.getAiQuizQuestions(
        subject: subject,
        grade: grade,
        difficulty: difficulty,
        count: 20,
      );

      state = state.copyWith(
        isLoading: false,
        questions: questions,
        isAiGenerated: true,
        isOfflineFallbackPrompt: false,
      );
    } catch (e) {
      // All API keys failed or network disconnected: prompt user with option to retry or practice offline
      state = state.copyWith(
        isLoading: false,
        isOfflineFallbackPrompt: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Explicit user confirmation to practice using the DepEd Curriculum Bank
  void loadOfflineDepEdCurriculumBank() {
    state = state.copyWith(isLoading: true, isOfflineFallbackPrompt: false);
    
    final questions = _quizRepository.getDepEdCurriculumQuestions(
      subject: state.subject,
      grade: state.grade,
      difficulty: state.difficulty,
      count: 20,
    );

    state = state.copyWith(
      isLoading: false,
      questions: questions,
      isAiGenerated: false,
      isOfflineFallbackPrompt: false,
      errorMessage: null,
    );
  }

  /// Re-attempts pure Gemini AI generation
  Future<void> retryAiGeneration() async {
    await startQuiz(
      subject: state.subject,
      grade: state.grade,
      difficulty: state.difficulty,
      studentName: state.studentName,
    );
  }

  void selectOption(int index) {
    if (state.isAnswerSubmitted) return;
    state = state.copyWith(selectedOptionIndex: index);
  }

  void submitAnswer() {
    final currentQ = state.currentQuestion;
    if (currentQ == null || state.selectedOptionIndex == null || state.isAnswerSubmitted) {
      return;
    }

    final isCorrect = state.selectedOptionIndex == currentQ.correctIndex;
    final newScore = isCorrect ? state.score + 1 : state.score;

    final detail = UserAnswerDetail(
      question: currentQ,
      selectedIndex: state.selectedOptionIndex!,
      isCorrect: isCorrect,
    );


    state = state.copyWith(
      isAnswerSubmitted: true,
      score: newScore,
      answers: [...state.answers, detail],
    );
  }

  void nextQuestion() {
    if (state.isLastQuestion) {
      _finishQuiz();
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        clearSelectedOption: true,
        isAnswerSubmitted: false,
      );
    }
  }

  void _finishQuiz() {
    final session = QuizSessionResult(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      studentName: state.studentName.isEmpty ? 'Student' : state.studentName,
      subject: state.subject,
      grade: state.grade,
      difficulty: state.difficulty,
      score: state.score,
      totalQuestions: state.totalQuestions,
      answers: state.answers,
      completedAt: DateTime.now(),
    );

    _ref.read(storageServiceProvider).saveQuizSession(session);

    state = state.copyWith(
      sessionResult: session,
    );
  }
}
