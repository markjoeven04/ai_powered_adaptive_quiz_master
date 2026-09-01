import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum QuizDifficulty {
  easy(
    id: 'easy',
    title: 'Easy',
    subtitle: 'Fun and foundational.',
    stars: 1,
    accentColor: AppColors.tertiary,
    cardBgColor: Color(0xFFE8F5E9),
    iconBgColor: AppColors.tertiaryFixedDim,
  ),
  medium(
    id: 'medium',
    title: 'Medium',
    subtitle: 'A balanced challenge.',
    stars: 2,
    accentColor: AppColors.secondary,
    cardBgColor: Color(0xFFFFF8E1),
    iconBgColor: AppColors.secondaryFixedDim,
  ),
  hard(
    id: 'hard',
    title: 'Hard',
    subtitle: 'Mastery level review.',
    stars: 3,
    accentColor: AppColors.error,
    cardBgColor: Color(0xFFFFEBEE),
    iconBgColor: AppColors.errorContainer,
  );

  final String id;
  final String title;
  final String subtitle;
  final int stars;
  final Color accentColor;
  final Color cardBgColor;
  final Color iconBgColor;

  const QuizDifficulty({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.stars,
    required this.accentColor,
    required this.cardBgColor,
    required this.iconBgColor,
  });

  static QuizDifficulty fromId(String id) {
    return QuizDifficulty.values.firstWhere(
      (d) => d.id == id,
      orElse: () => QuizDifficulty.medium,
    );
  }
}
