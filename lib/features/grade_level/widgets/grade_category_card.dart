import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/models/grade_level_enum.dart';

class GradeCategoryCard extends StatelessWidget {
  final GradeCategory category;
  final int? selectedGrade;
  final ValueChanged<int> onGradeSelected;

  const GradeCategoryCard({
    super.key,
    required this.category,
    required this.selectedGrade,
    required this.onGradeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: category.color.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header (Icon + Name)
          Row(
            children: [
              Icon(
                category.icon,
                color: category.color,
                size: 26,
              ),
              const SizedBox(width: 8),
              Text(
                category.name,
                style: AppTypography.headlineMd(color: AppColors.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Grade Buttons in a row
          Row(
            children: category.grades.map((grade) {
              final isSelected = selectedGrade == grade;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    child: ElevatedButton(
                      onPressed: () => onGradeSelected(grade),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? category.color
                            : AppColors.surfaceContainerLowest,
                        foregroundColor: isSelected
                            ? Colors.white
                            : category.color,
                        elevation: isSelected ? 3 : 1,
                        shadowColor: category.color.withValues(alpha: 0.2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Grade $grade',
                          style: AppTypography.labelMd(
                            color: isSelected ? Colors.white : category.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
