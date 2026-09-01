import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/models/difficulty_enum.dart';

class DifficultyCard extends StatelessWidget {
  final QuizDifficulty difficulty;
  final bool isSelected;
  final VoidCallback onTap;

  const DifficultyCard({
    super.key,
    required this.difficulty,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? difficulty.cardBgColor
            : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? difficulty.accentColor : AppColors.surfaceContainer,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? difficulty.accentColor.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: isSelected ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                // Star Icon Container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? difficulty.accentColor
                        : AppColors.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        difficulty.stars,
                        (index) => Icon(
                          Icons.star_rounded,
                          size: difficulty.stars == 1 ? 28 : (difficulty.stars == 2 ? 22 : 18),
                          color: isSelected
                              ? Colors.white
                              : difficulty.accentColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        difficulty.title,
                        style: AppTypography.headlineMd(
                          color: isSelected
                              ? difficulty.accentColor
                              : AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        difficulty.subtitle,
                        style: AppTypography.bodyMd(
                          color: isSelected
                              ? difficulty.accentColor.withValues(alpha: 0.85)
                              : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection Checkmark
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: difficulty.accentColor,
                    size: 26,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
