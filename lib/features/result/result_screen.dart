import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/quiz_session_model.dart';
import '../navigation/main_nav_shell.dart';
import '../quiz/quiz_controller.dart';
import '../quiz/quiz_screen.dart';
import 'widgets/confetti_overlay.dart';

class ResultScreen extends ConsumerWidget {
  final QuizSessionResult result;

  const ResultScreen({super.key, required this.result});

  void _onTryAgain(BuildContext context, WidgetRef ref) {
    ref.read(activeQuizProvider.notifier).startQuiz(
          subject: result.subject,
          grade: result.grade,
          difficulty: result.difficulty,
          studentName: result.studentName,
        );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  void _onNewSubject(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavShell(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHighScorer = result.score >= 14;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => _onNewSubject(context),
        ),
        title: Text(
          'Quiz Result',
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
      body: Stack(
        children: [
          // Confetti Particle Overlay if high score
          if (isHighScorer) const ConfettiOverlay(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),

                          // Score-Based Celebratory Circle Badge
                          Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (result.score >= 18
                                      ? AppColors.secondaryContainer
                                      : result.score >= 14
                                          ? AppColors.tertiaryContainer
                                          : result.score >= 10
                                              ? AppColors.primaryContainer
                                              : Colors.deepOrange)
                                  .withValues(alpha: 0.14),
                              border: Border.all(
                                color: (result.score >= 18
                                        ? AppColors.secondaryContainer
                                        : result.score >= 14
                                            ? AppColors.tertiaryContainer
                                            : result.score >= 10
                                                ? AppColors.primary
                                                : Colors.deepOrange)
                                    .withValues(alpha: 0.28),
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (result.score >= 18
                                          ? AppColors.secondaryContainer
                                          : result.score >= 14
                                              ? AppColors.tertiaryContainer
                                              : result.score >= 10
                                                  ? AppColors.primary
                                                  : Colors.deepOrange)
                                      .withValues(alpha: 0.18),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                result.primaryEmoji,
                                style: const TextStyle(
                                  fontSize: 78,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Dynamic Feedback Title & Subtitle
                          Text(
                            result.feedbackTitle,
                            style: AppTypography.headlineLg(color: AppColors.onSurface),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            result.feedbackSubtitle,
                            style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // Final Score Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.surfaceContainerHigh,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'FINAL SCORE',
                                  style: AppTypography.labelSm(
                                    color: AppColors.onSurfaceVariant,
                                  ).copyWith(letterSpacing: 1.5),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${result.score}',
                                      style: AppTypography.headlineXl(color: AppColors.primary)
                                          .copyWith(fontSize: 48, fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      ' / ${result.totalQuestions}',
                                      style: AppTypography.headlineMd(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isHighScorer
                                        ? AppColors.tertiaryContainer.withValues(alpha: 0.12)
                                        : AppColors.primaryContainer.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    '${result.percentage.toStringAsFixed(0)}% Accuracy • Grade ${result.grade} ${result.subject.displayName}',
                                    style: AppTypography.labelSm(
                                      color: isHighScorer
                                          ? AppColors.tertiaryContainer
                                          : AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Sticky Action Buttons
                  Column(
                    children: [
                      // Try Again Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => _onTryAgain(context, ref),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.refresh_rounded, color: AppColors.onPrimary),
                              const SizedBox(width: 8),
                              Text(
                                AppStrings.tryAgain,
                                style: AppTypography.labelMd(color: AppColors.onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // New Subject Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => _onNewSubject(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceContainer,
                            foregroundColor: AppColors.onSurface,
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.subject_rounded, color: AppColors.onSurface),
                              const SizedBox(width: 8),
                              Text(
                                AppStrings.newSubject,
                                style: AppTypography.labelMd(color: AppColors.onSurface),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
