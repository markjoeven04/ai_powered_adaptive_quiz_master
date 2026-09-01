import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum GradeCategory {
  primary(
    name: 'Primary',
    icon: Icons.child_care_rounded,
    color: AppColors.primary,
    containerColor: Color(0xFFEFF4FF),
    grades: [1, 2, 3],
  ),
  intermediate(
    name: 'Intermediate',
    icon: Icons.backpack_rounded,
    color: AppColors.secondary,
    containerColor: Color(0xFFFFF9E6),
    grades: [4, 5, 6],
  ),
  juniorHigh(
    name: 'Junior High',
    icon: Icons.science_rounded,
    color: AppColors.tertiary,
    containerColor: Color(0xFFE8F8F0),
    grades: [7, 8, 9],
  ),
  seniorHigh(
    name: 'Senior High',
    icon: Icons.school_rounded,
    color: AppColors.error,
    containerColor: Color(0xFFFFECEB),
    grades: [10, 11, 12],
  );

  final String name;
  final IconData icon;
  final Color color;
  final Color containerColor;
  final List<int> grades;

  const GradeCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.containerColor,
    required this.grades,
  });

  static GradeCategory forGrade(int grade) {
    if (grade <= 3) return GradeCategory.primary;
    if (grade <= 6) return GradeCategory.intermediate;
    if (grade <= 9) return GradeCategory.juniorHigh;
    return GradeCategory.seniorHigh;
  }
}

class GradeLevel {
  final int grade;

  const GradeLevel(this.grade);

  String get label => 'Grade $grade';
  GradeCategory get category => GradeCategory.forGrade(grade);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeLevel && runtimeType == other.runtimeType && grade == other.grade;

  @override
  int get hashCode => grade.hashCode;
}
