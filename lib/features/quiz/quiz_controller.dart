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

  /// Initializes and generates 20 questions tailored to the student
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
    );

    try {
      final questions = await _quizRepository.getQuizQuestions(
        subject: subject,
        grade: grade,
        difficulty: difficulty,
        count: 20,
      );

      state = state.copyWith(
        isLoading: false,
        questions: questions,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load questions. Please check your connection.',
      );
    }
  }

  void selectOption(int index) {
    if (state.isAnswerSubmitted) return;
    state = state.copyWith(selectedOptionIndex: index);
  }

  void submitAnswer() {
    if (state.selectedOptionIndex == null || state.isAnswerSubmitted) return;
    final currentQ = state.currentQuestion;
    if (currentQ == null) return;

    final isCorrect = state.selectedOptionIndex == currentQ.correctIndex;
    final updatedScore = isCorrect ? state.score + 1 : state.score;

    final answerDetail = UserAnswerDetail(
      question: currentQ,
      selectedIndex: state.selectedOptionIndex!,
      isCorrect: isCorrect,
    );

    final updatedAnswers = List<UserAnswerDetail>.from(state.answers)..add(answerDetail);

    state = state.copyWith(
      isAnswerSubmitted: true,
      score: updatedScore,
      answers: updatedAnswers,
    );
  }

  Future<void> nextQuestion() async {
    if (state.isLastQuestion) {
      // Finalize Quiz Session
      final result = QuizSessionResult(
        id: 'session_${DateTime.now().millisecondsSinceEpoch}',
        studentName: state.studentName.isEmpty ? 'Student' : state.studentName,
        subject: state.subject,
        grade: state.grade,
        difficulty: state.difficulty,
        totalQuestions: state.questions.length,
        score: state.score,
        completedAt: DateTime.now(),
        answers: state.answers,
      );

      // Record in local history & update stats
      await _ref.read(quizHistoryProvider.notifier).addResult(result);
      _ref.read(userProfileProvider.notifier).refresh();

      state = state.copyWith(sessionResult: result);
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        clearSelectedOption: true,
        isAnswerSubmitted: false,
      );
    }
  }

  void resetQuiz() {
    startQuiz(
      subject: state.subject,
      grade: state.grade,
      difficulty: state.difficulty,
      studentName: state.studentName,
    );
  }
}

final activeQuizProvider =
    StateNotifierProvider<ActiveQuizNotifier, ActiveQuizState>((ref) {
  final quizRepo = ref.watch(quizRepositoryProvider);
  return ActiveQuizNotifier(quizRepo, ref);
});
