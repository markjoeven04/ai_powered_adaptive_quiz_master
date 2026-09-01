import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/difficulty_enum.dart';
import '../../core/models/subject_enum.dart';
import '../../core/providers/app_providers.dart';
import '../quiz/quiz_screen.dart';

import 'widgets/difficulty_card.dart';

class DifficultyScreen extends ConsumerWidget {
  const DifficultyScreen({super.key});

  void _onStartReview(BuildContext context, WidgetRef ref) {
    final subject = ref.read(selectedSubjectProvider) ?? Subject.science;
    final grade = ref.read(selectedGradeProvider) ?? 1;
    final difficulty = ref.read(selectedDifficultyProvider);
    final studentName = ref.read(studentNameProvider);

    // Initialize and trigger AI question generation
    ref.read(activeQuizProvider.notifier).startQuiz(
          subject: subject,
          grade: grade,
          difficulty: difficulty,
          studentName: studentName,
        );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDifficulty = ref.watch(selectedDifficultyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.activeQuizSession,
          style: AppTypography.headlineMd(color: AppColors.onSurface),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
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
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // Psychology Header Badge
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainer,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          color: AppColors.primary,
                          size: 34,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title & Subtitle
                      Text(
                        AppStrings.difficultyHeader,
                        style: AppTypography.headlineLg(color: AppColors.onSurface),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppStrings.difficultyPrompt,
                        style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Difficulty Cards (Easy, Medium, Hard)
                      DifficultyCard(
                        difficulty: QuizDifficulty.easy,
                        isSelected: selectedDifficulty == QuizDifficulty.easy,
                        onTap: () {
                          ref.read(selectedDifficultyProvider.notifier).state =
                              QuizDifficulty.easy;
                        },
                      ),
                      const SizedBox(height: 16),

                      DifficultyCard(
                        difficulty: QuizDifficulty.medium,
                        isSelected: selectedDifficulty == QuizDifficulty.medium,
                        onTap: () {
                          ref.read(selectedDifficultyProvider.notifier).state =
                              QuizDifficulty.medium;
                        },
                      ),
                      const SizedBox(height: 16),

                      DifficultyCard(
                        difficulty: QuizDifficulty.hard,
                        isSelected: selectedDifficulty == QuizDifficulty.hard,
                        onTap: () {
                          ref.read(selectedDifficultyProvider.notifier).state =
                              QuizDifficulty.hard;
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Sticky "Start Review →" Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _onStartReview(context, ref),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.startReview,
                        style: AppTypography.headlineMd(color: AppColors.onPrimary),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, color: AppColors.onPrimary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
