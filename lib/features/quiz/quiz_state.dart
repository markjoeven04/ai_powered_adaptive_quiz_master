import '../../core/models/question_model.dart';
import '../../core/models/subject_enum.dart';
import '../../core/models/difficulty_enum.dart';
import '../../core/models/quiz_session_model.dart';

class ActiveQuizState {
  final bool isLoading;
  final String? errorMessage;
  final bool isOfflineFallbackPrompt;
  final bool isAiGenerated;
  final Subject subject;
  final int grade;
  final QuizDifficulty difficulty;
  final String studentName;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int? selectedOptionIndex;
  final bool isAnswerSubmitted;
  final int score;
  final List<UserAnswerDetail> answers;
  final QuizSessionResult? sessionResult;

  const ActiveQuizState({
    this.isLoading = false,
    this.errorMessage,
    this.isOfflineFallbackPrompt = false,
    this.isAiGenerated = true,
    required this.subject,
    required this.grade,
    required this.difficulty,
    required this.studentName,
    this.questions = const [],
    this.currentIndex = 0,
    this.selectedOptionIndex,
    this.isAnswerSubmitted = false,
    this.score = 0,
    this.answers = const [],
    this.sessionResult,
  });

  QuizQuestion? get currentQuestion =>
      (questions.isNotEmpty && currentIndex < questions.length)
          ? questions[currentIndex]
          : null;

  int get totalQuestions => questions.length;

  double get progressFraction =>
      (totalQuestions > 0) ? (currentIndex + 1) / totalQuestions : 0.0;

  bool get isLastQuestion =>
      questions.isNotEmpty && currentIndex == questions.length - 1;

  bool get isCurrentAnswerCorrect {
    if (currentQuestion == null || selectedOptionIndex == null) return false;
    return selectedOptionIndex == currentQuestion!.correctIndex;
  }

  ActiveQuizState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isOfflineFallbackPrompt,
    bool? isAiGenerated,
    Subject? subject,
    int? grade,
    QuizDifficulty? difficulty,
    String? studentName,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    bool? isAnswerSubmitted,
    int? score,
    List<UserAnswerDetail>? answers,
    QuizSessionResult? sessionResult,
  }) {
    return ActiveQuizState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isOfflineFallbackPrompt: isOfflineFallbackPrompt ?? this.isOfflineFallbackPrompt,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      difficulty: difficulty ?? this.difficulty,
      studentName: studentName ?? this.studentName,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOptionIndex: clearSelectedOption ? null : (selectedOptionIndex ?? this.selectedOptionIndex),
      isAnswerSubmitted: isAnswerSubmitted ?? this.isAnswerSubmitted,
      score: score ?? this.score,
      answers: answers ?? this.answers,
      sessionResult: sessionResult ?? this.sessionResult,
    );
  }
}
