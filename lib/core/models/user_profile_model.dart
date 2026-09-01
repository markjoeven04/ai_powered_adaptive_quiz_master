class UserProfile {
  final String name;
  final int totalQuizzes;
  final int totalScore;
  final int streakDays;
  final DateTime lastActiveDate;
  final List<String> unlockedBadgeIds;

  const UserProfile({
    required this.name,
    this.totalQuizzes = 0,
    this.totalScore = 0,
    this.streakDays = 1,
    required this.lastActiveDate,
    this.unlockedBadgeIds = const [],
  });

  UserProfile copyWith({
    String? name,
    int? totalQuizzes,
    int? totalScore,
    int? streakDays,
    DateTime? lastActiveDate,
    List<String>? unlockedBadgeIds,
  }) {
    return UserProfile(
      name: name ?? this.name,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      totalScore: totalScore ?? this.totalScore,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      unlockedBadgeIds: unlockedBadgeIds ?? this.unlockedBadgeIds,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'totalQuizzes': totalQuizzes,
        'totalScore': totalScore,
        'streakDays': streakDays,
        'lastActiveDate': lastActiveDate.toIso8601String(),
        'unlockedBadgeIds': unlockedBadgeIds,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] as String? ?? '',
        totalQuizzes: json['totalQuizzes'] as int? ?? 0,
        totalScore: json['totalScore'] as int? ?? 0,
        streakDays: json['streakDays'] as int? ?? 1,
        lastActiveDate: DateTime.tryParse(json['lastActiveDate'] as String? ?? '') ?? DateTime.now(),
        unlockedBadgeIds: (json['unlockedBadgeIds'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );
}
