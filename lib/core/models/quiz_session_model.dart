import 'question_model.dart';
import 'subject_enum.dart';
import 'difficulty_enum.dart';

class UserAnswerDetail {
  final QuizQuestion question;
  final int selectedIndex;
  final bool isCorrect;

  const UserAnswerDetail({
    required this.question,
    required this.selectedIndex,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
        'question': question.toJson(),
        'selectedIndex': selectedIndex,
        'isCorrect': isCorrect,
      };

  factory UserAnswerDetail.fromJson(Map<String, dynamic> json) =>
      UserAnswerDetail(
        question: QuizQuestion.fromJson(json['question'] as Map<String, dynamic>),
        selectedIndex: json['selectedIndex'] as int,
        isCorrect: json['isCorrect'] as bool,
      );
}

class QuizSessionResult {
  final String id;
  final String studentName;
  final Subject subject;
  final int grade;
  final QuizDifficulty difficulty;
  final int totalQuestions;
  final int score;
  final DateTime completedAt;
  final List<UserAnswerDetail> answers;

  const QuizSessionResult({
    required this.id,
    required this.studentName,
    required this.subject,
    required this.grade,
    required this.difficulty,
    required this.totalQuestions,
    required this.score,
    required this.completedAt,
    required this.answers,
  });

  double get percentage => (totalQuestions > 0) ? (score / totalQuestions) * 100 : 0;

  String get performanceTier {
    if (score >= 18) return 'master_scholar';
    if (score >= 14) return 'great_job';
    if (score >= 10) return 'good_effort';
    return 'keep_trying';
  }

  String get feedbackTitle {
    if (score >= 18) return 'Master Scholar! Outstanding, $studentName!';
    if (score >= 14) return 'Great Job! Solid work, $studentName!';
    if (score >= 10) return 'Good Effort! Practice makes perfect.';
    return "Keep Trying! Don't give up!";
  }

  String get feedbackSubtitle {
    if (score >= 18) return 'You have mastered this topic with flying colors!';
    if (score >= 14) return 'Strong understanding! A little more practice and you will get 100%!';
    if (score >= 10) return 'You are on the right track. Review the explanations to level up!';
    return 'Every expert was once a beginner. Let’s try again!';
  }

  String get feedbackEmoji {
    if (score >= 18) return '🌟 🥳';
    if (score >= 14) return '😄 👍';
    if (score >= 10) return '🙂 📚';
    return '🤓 💪';
  }

  String get primaryEmoji {
    if (score >= 18) return '🏆';
    if (score >= 14) return '🎉';
    if (score >= 10) return '💡';
    return '💪';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'studentName': studentName,
        'subject': subject.id,
        'grade': grade,
        'difficulty': difficulty.id,
        'totalQuestions': totalQuestions,
        'score': score,
        'completedAt': completedAt.toIso8601String(),
        'answers': answers.map((a) => a.toJson()).toList(),
      };

  factory QuizSessionResult.fromJson(Map<String, dynamic> json) =>
      QuizSessionResult(
        id: json['id'] as String,
        studentName: json['studentName'] as String? ?? 'Student',
        subject: Subject.fromId(json['subject'] as String? ?? 'english'),
        grade: json['grade'] as int? ?? 1,
        difficulty: QuizDifficulty.fromId(json['difficulty'] as String? ?? 'medium'),
        totalQuestions: json['totalQuestions'] as int? ?? 20,
        score: json['score'] as int? ?? 0,
        completedAt: DateTime.tryParse(json['completedAt'] as String? ?? '') ?? DateTime.now(),
        answers: (json['answers'] as List<dynamic>?)
                ?.map((a) => UserAnswerDetail.fromJson(a as Map<String, dynamic>))
                .toList() ??
            [],
      );
}
