import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../result/result_screen.dart';
import 'quiz_controller.dart';
import 'widgets/question_card.dart';
import 'widgets/option_tile.dart';
import 'widgets/explanation_panel.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Leave Quiz Session?', style: AppTypography.headlineMd()),
        content: Text(
          'Your current progress in this review session will be discarded. Are you sure?',
          style: AppTypography.bodyMd(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Keep Playing', style: AppTypography.labelMd(color: AppColors.primary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(activeQuizProvider);
    final quizNotifier = ref.read(activeQuizProvider.notifier);

    // If quiz completed, navigate to result screen
    if (quizState.sessionResult != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResultScreen(result: quizState.sessionResult!),
          ),
        );
      });
    }

    if (quizState.isLoading) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final leave = await _onWillPop(context);
          if (leave && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      AppAssets.mascotRobot,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.auto_awesome_rounded,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Generating AI Review Questions...',
                    style: AppTypography.headlineMd(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Preparing Grade ${quizState.grade} ${quizState.subject.displayName} (${quizState.difficulty.title})',
                    style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = quizState.currentQuestion;
    if (currentQuestion == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(AppStrings.activeQuizSession, style: AppTypography.headlineMd()),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text('Unable to load questions', style: AppTypography.headlineMd()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => quizNotifier.resetQuiz(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    final questionNum = quizState.currentIndex + 1;
    final totalQ = quizState.totalQuestions;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final leave = await _onWillPop(context);
        if (leave && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
            onPressed: () async {
              final leave = await _onWillPop(context);
              if (leave && context.mounted) {
                Navigator.of(context).pop();
              }
            },
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
          child: Column(
            children: [
              // Progress Info Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QUESTION $questionNum / $totalQ',
                      style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                    ),
                    Text(
                      'SCORE: ${quizState.score}/$totalQ',
                      style: AppTypography.labelSm(color: AppColors.primary)
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),

              // Animated Linear Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: quizState.progressFraction,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Scrollable Quiz Area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // Question Card with prompt & image
                      QuestionCard(
                        prompt: currentQuestion.prompt,
                        imageKeyword: currentQuestion.imageKeyword,
                        subject: currentQuestion.subject,
                      ),
                      const SizedBox(height: 20),

                      // Multiple Choice Options (A, B, C, D)
                      ...List.generate(currentQuestion.options.length, (index) {
                        final isSelected = quizState.selectedOptionIndex == index;
                        final isCorrect = index == currentQuestion.correctIndex;
                        final isUserSelected = isSelected;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: OptionTile(
                            index: index,
                            text: currentQuestion.options[index],
                            isSelected: isSelected,
                            isAnswerSubmitted: quizState.isAnswerSubmitted,
                            isCorrectAnswer: isCorrect,
                            isUserSelected: isUserSelected,
                            onTap: () => quizNotifier.selectOption(index),
                          ),
                        );
                      }),

                      // Explanation Panel (Visible after submission)
                      if (quizState.isAnswerSubmitted) ...[
                        const SizedBox(height: 12),
                        ExplanationPanel(
                          explanation: currentQuestion.explanation,
                          isCorrect: quizState.isCurrentAnswerCorrect,
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Sticky Bottom Action Button Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!quizState.isAnswerSubmitted) {
                        if (quizState.selectedOptionIndex != null) {
                          quizNotifier.submitAnswer();
                        }
                      } else {
                        quizNotifier.nextQuestion();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (!quizState.isAnswerSubmitted && quizState.selectedOptionIndex == null)
                          ? AppColors.surfaceContainerHigh
                          : AppColors.primary,
                      foregroundColor: (!quizState.isAnswerSubmitted && quizState.selectedOptionIndex == null)
                          ? AppColors.outline
                          : AppColors.onPrimary,
                      elevation: (!quizState.isAnswerSubmitted && quizState.selectedOptionIndex == null)
                          ? 0
                          : 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          !quizState.isAnswerSubmitted
                              ? AppStrings.submitAnswer
                              : (quizState.isLastQuestion
                                  ? AppStrings.viewResults
                                  : AppStrings.nextQuestion),
                          style: AppTypography.headlineMd(
                            color: (!quizState.isAnswerSubmitted && quizState.selectedOptionIndex == null)
                                ? AppColors.outline
                                : AppColors.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: (!quizState.isAnswerSubmitted && quizState.selectedOptionIndex == null)
                              ? AppColors.outline
                              : AppColors.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
