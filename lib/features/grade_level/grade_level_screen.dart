import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/grade_level_enum.dart';
import '../../core/providers/app_providers.dart';
import '../difficulty/difficulty_screen.dart';
import '../settings/settings_modal.dart';
import 'widgets/grade_category_card.dart';

class GradeLevelScreen extends ConsumerWidget {
  const GradeLevelScreen({super.key});

  void _onGradeSelected(BuildContext context, WidgetRef ref, int grade) {
    ref.read(selectedGradeProvider.notifier).state = grade;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DifficultyScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGrade = ref.watch(selectedGradeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                AppAssets.logoSpark,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Learn',
              style: AppTypography.headlineMd(color: AppColors.primary),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              tooltip: 'Settings & Profile',
              onPressed: () => SettingsModal.show(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Greeting
              Text(
                AppStrings.gradeHeader,
                style: AppTypography.headlineLg(color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                AppStrings.gradePrompt,
                style: AppTypography.bodyLg(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 24),

              // Category Cards (Primary, Intermediate, Junior High, Senior High)
              GradeCategoryCard(
                category: GradeCategory.primary,
                selectedGrade: selectedGrade,
                onGradeSelected: (grade) => _onGradeSelected(context, ref, grade),
              ),
              const SizedBox(height: 16),

              GradeCategoryCard(
                category: GradeCategory.intermediate,
                selectedGrade: selectedGrade,
                onGradeSelected: (grade) => _onGradeSelected(context, ref, grade),
              ),
              const SizedBox(height: 16),

              GradeCategoryCard(
                category: GradeCategory.juniorHigh,
                selectedGrade: selectedGrade,
                onGradeSelected: (grade) => _onGradeSelected(context, ref, grade),
              ),
              const SizedBox(height: 16),

              GradeCategoryCard(
                category: GradeCategory.seniorHigh,
                selectedGrade: selectedGrade,
                onGradeSelected: (grade) => _onGradeSelected(context, ref, grade),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
