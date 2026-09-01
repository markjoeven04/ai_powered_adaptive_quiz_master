import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_strings.dart';

class ExplanationPanel extends StatelessWidget {
  final String explanation;
  final bool isCorrect;

  const ExplanationPanel({
    super.key,
    required this.explanation,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = isCorrect ? AppColors.tertiaryContainer : AppColors.primary;
    final bgColor = isCorrect
        ? AppColors.tertiaryContainer.withValues(alpha: 0.08)
        : AppColors.primaryContainer.withValues(alpha: 0.08);
    final borderColor = isCorrect
        ? AppColors.tertiaryContainer.withValues(alpha: 0.25)
        : AppColors.primaryContainer.withValues(alpha: 0.25);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.lightbulb_rounded : Icons.info_rounded,
            color: themeColor,
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.explanation,
                  style: AppTypography.labelMd(color: themeColor).copyWith(
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  explanation,
                  style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
