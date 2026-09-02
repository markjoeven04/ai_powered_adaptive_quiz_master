import 'package:flutter/material.dart';

class BadgeModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const BadgeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  BadgeModel copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return BadgeModel(
      id: id,
      title: title,
      description: description,
      icon: icon,
      color: color,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isUnlocked': isUnlocked,
        'unlockedAt': unlockedAt?.toIso8601String(),
      };

  static List<BadgeModel> get defaultBadges => [
        const BadgeModel(
          id: 'first_quiz',
          title: 'First Step',
          description: 'Completed your first Bright Spark quiz session!',
          icon: Icons.rocket_launch_rounded,
          color: Color(0xFF0058BE),
        ),
        const BadgeModel(
          id: 'perfect_20',
          title: 'Master Scholar',
          description: 'Scored 18 or more on any subject quiz!',
          icon: Icons.emoji_events_rounded,
          color: Color(0xFFFFC329),
        ),
        const BadgeModel(
          id: 'science_star',
          title: 'Science Star',
          description: 'Completed a Science review session with excellence.',
          icon: Icons.science_rounded,
          color: Color(0xFF00855B),
        ),
        const BadgeModel(
          id: 'math_wizard',
          title: 'Math Wizard',
          description: 'Conquered a challenging Math review quiz.',
          icon: Icons.calculate_rounded,
          color: Color(0xFFBA1A1A),
        ),
        const BadgeModel(
          id: 'history_buff',
          title: 'Kasaysayan Master',
          description: 'Showcased great Philippine History knowledge.',
          icon: Icons.flag_rounded,
          color: Color(0xFF2170E4),
        ),
        const BadgeModel(
          id: 'english_ace',
          title: 'Grammar Ace',
          description: 'Mastered English vocabulary & comprehension.',
          icon: Icons.auto_stories_rounded,
          color: Color(0xFF795900),
        ),
        const BadgeModel(
          id: 'streak_3',
          title: 'Dedicated Learner',
          description: 'Maintained a 3-quiz self-study streak!',
          icon: Icons.local_fire_department_rounded,
          color: Color(0xFFF97316),
        ),
        const BadgeModel(
          id: 'speed_demon',
          title: 'Quick Thinker',
          description: 'Finished a quiz session with high accuracy.',
          icon: Icons.bolt_rounded,
          color: Color(0xFF8B5CF6),
        ),
      ];
}
