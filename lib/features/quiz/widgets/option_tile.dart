import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isAnswerSubmitted;
  final bool isCorrectAnswer;
  final bool isUserSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isAnswerSubmitted,
    required this.isCorrectAnswer,
    required this.isUserSelected,
    required this.onTap,
  });

  String get optionLetter {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
      default:
        return 'D';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cardBgColor = AppColors.surfaceContainerLowest;
    Color borderColor = AppColors.surfaceContainer;
    Color letterBgColor = AppColors.surfaceContainer;
    Color letterTextColor = AppColors.onSurfaceVariant;
    Color textColor = AppColors.onSurface;
    Widget? trailingIcon;

    if (!isAnswerSubmitted) {
      if (isSelected) {
        cardBgColor = AppColors.primaryFixed.withValues(alpha: 0.5);
        borderColor = AppColors.primary;
        letterBgColor = AppColors.primary;
        letterTextColor = AppColors.onPrimary;
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: AppColors.primary,
          size: 22,
        );
      }
    } else {
      if (isCorrectAnswer) {
        cardBgColor = AppColors.tertiaryFixedDim.withValues(alpha: 0.35);
        borderColor = AppColors.tertiaryContainer;
        letterBgColor = AppColors.tertiaryContainer;
        letterTextColor = AppColors.onTertiary;
        textColor = AppColors.onSurface;
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: AppColors.tertiaryContainer,
          size: 24,
        );
      } else if (isUserSelected && !isCorrectAnswer) {
        cardBgColor = AppColors.errorContainer.withValues(alpha: 0.4);
        borderColor = AppColors.error;
        letterBgColor = AppColors.error;
        letterTextColor = AppColors.onError;
        trailingIcon = const Icon(
          Icons.cancel_rounded,
          color: AppColors.error,
          size: 24,
        );
      } else {
        cardBgColor = AppColors.surfaceContainerLowest.withValues(alpha: 0.6);
        textColor = AppColors.onSurfaceVariant.withValues(alpha: 0.6);
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: isSelected || (isAnswerSubmitted && isCorrectAnswer) ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAnswerSubmitted ? null : onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Option Letter (A, B, C, D)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: letterBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      optionLetter,
                      style: AppTypography.headlineMd(color: letterTextColor)
                          .copyWith(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Option Text
                Expanded(
                  child: Text(
                    text,
                    style: AppTypography.bodyLg(color: textColor),
                  ),
                ),

                // Trailing Feedback Icon
                if (trailingIcon != null) trailingIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
