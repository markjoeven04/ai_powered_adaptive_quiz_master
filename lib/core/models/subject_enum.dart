import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum Subject {
  english(
    id: 'english',
    displayName: 'English',
    iconEmoji: '📖',
    iconData: Icons.menu_book_rounded,
    containerColor: Color(0xFFE8F5E9),
    iconColor: AppColors.tertiaryContainer,
  ),
  science(
    id: 'science',
    displayName: 'Science',
    iconEmoji: '🧪',
    iconData: Icons.science_rounded,
    containerColor: Color(0xFFFFF8E1),
    iconColor: AppColors.secondaryContainer,
  ),
  math(
    id: 'math',
    displayName: 'Math',
    iconEmoji: '🧮',
    iconData: Icons.calculate_rounded,
    containerColor: Color(0xFFFFEBEE),
    iconColor: AppColors.error,
  ),
  philippineHistory(
    id: 'philippine_history',
    displayName: 'Philippine History',
    iconEmoji: '🇵🇭',
    iconData: Icons.history_edu_rounded,
    containerColor: Color(0xFFE3F2FD),
    iconColor: AppColors.primary,
  );

  final String id;
  final String displayName;
  final String iconEmoji;
  final IconData iconData;
  final Color containerColor;
  final Color iconColor;

  const Subject({
    required this.id,
    required this.displayName,
    required this.iconEmoji,
    required this.iconData,
    required this.containerColor,
    required this.iconColor,
  });

  static Subject fromId(String id) {
    return Subject.values.firstWhere(
      (s) => s.id == id,
      orElse: () => Subject.english,
    );
  }
}
