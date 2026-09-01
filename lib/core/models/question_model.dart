class QuizQuestion {
  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? imageUrl;
  final String? imageKeyword;
  final String subject;
  final int grade;
  final String difficulty;

  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.imageUrl,
    this.imageKeyword,
    required this.subject,
    required this.grade,
    required this.difficulty,
  });

  String get correctAnswerText =>
      (correctIndex >= 0 && correctIndex < options.length)
          ? options[correctIndex]
          : '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prompt': prompt,
      'options': options,
      'correctIndex': correctIndex,
      'explanation': explanation,
      'imageUrl': imageUrl,
      'imageKeyword': imageKeyword,
      'subject': subject,
      'grade': grade,
      'difficulty': difficulty,
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      prompt: json['prompt'] as String? ?? json['question'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      correctIndex: json['correctIndex'] as int? ?? json['correct_index'] as int? ?? 0,
      explanation: json['explanation'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      imageKeyword: json['imageKeyword'] as String? ?? json['keyword'] as String?,
      subject: json['subject'] as String? ?? 'English',
      grade: json['grade'] as int? ?? 1,
      difficulty: json['difficulty'] as String? ?? 'medium',
    );
  }
}
