import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/providers/app_providers.dart';
import '../result/result_screen.dart';
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

    // 1. Loading State with Mascot Animation
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
                    'Crafting Grade ${quizState.grade} ${quizState.subject.displayName} (${quizState.difficulty.title})',
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

    // 2. Offline / AI Generation Failed Dialog (Option 3 Implementation)
    if (quizState.isOfflineFallbackPrompt || (quizState.errorMessage != null && quizState.questions.isEmpty)) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Connection Status', style: AppTypography.headlineMd(color: AppColors.onSurface)),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Status Icon Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.wifi_off_rounded,
                        size: 40,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Internet Connection Required',
                      style: AppTypography.headlineMd(color: AppColors.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    // Descriptive Explanation (Clean, Non-button look)
                    Text(
                      'An active internet connection is required to generate dynamic AI questions. You can retry connecting or practice with our offline DepEd bank.',
                      style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // 1. Primary Action: Retry AI Generation
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: () => quizNotifier.retryAiGeneration(),
                        icon: const Icon(Icons.refresh_rounded, size: 20),
                        label: Text(
                          'Retry AI Generation',
                          style: AppTypography.labelMd(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2. Secondary Interactive Action: Practice Offline DepEd Bank
                    Material(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () => quizNotifier.loadOfflineDepEdCurriculumBank(),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.outline.withValues(alpha: 0.35),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Practice Offline (DepEd Bank)',
                                      style: AppTypography.labelMd(color: AppColors.onSurface),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Take 20 verified standard questions',
                                      style: AppTypography.labelSm(color: AppColors.onSurfaceVariant),
                                    ),

                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 3. Tertiary Action: Cancel / Change Settings
                    TextButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.onSurfaceVariant),
                      label: Text(
                        'Change Quiz Settings',
                        style: AppTypography.labelMd(color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to Setup'),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: quizState.isAiGenerated
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: quizState.isAiGenerated
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      quizState.isAiGenerated ? Icons.auto_awesome_rounded : Icons.school_rounded,
                      size: 16,
                      color: quizState.isAiGenerated ? AppColors.primary : Colors.orange.shade800,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      quizState.isAiGenerated ? 'Adaptive AI' : 'DepEd Bank',
                      style: AppTypography.labelSm(
                        color: quizState.isAiGenerated ? AppColors.primary : Colors.orange.shade800,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress Bar & Question Counter
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'QUESTION $questionNum / $totalQ',
                    style: AppTypography.labelSm(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'SCORE: ${quizState.score}/$totalQ',
                    style: AppTypography.labelSm(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: quizState.progressFraction,
                  minHeight: 6,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),

            // Scrollable Question & Options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    QuestionCard(
                      prompt: currentQuestion.prompt,
                      imageKeyword: currentQuestion.imageKeyword,
                      subject: currentQuestion.subject,
                    ),
                    const SizedBox(height: 16),

                    // Options List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        final isSelected = quizState.selectedOptionIndex == index;
                        final isCorrect = index == currentQuestion.correctIndex;
                        return OptionTile(
                          index: index,
                          text: currentQuestion.options[index],
                          isSelected: isSelected,
                          isAnswerSubmitted: quizState.isAnswerSubmitted,
                          isCorrectAnswer: isCorrect,
                          isUserSelected: isSelected,
                          onTap: () => quizNotifier.selectOption(index),
                        );
                      },
                    ),

                    // Explanation Panel
                    if (quizState.isAnswerSubmitted) ...[
                      const SizedBox(height: 16),
                      ExplanationPanel(
                        isCorrect: quizState.isCurrentAnswerCorrect,
                        explanation: currentQuestion.explanation,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Action Button
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: quizState.selectedOptionIndex == null
                      ? null
                      : () {
                          if (!quizState.isAnswerSubmitted) {
                            quizNotifier.submitAnswer();
                          } else {
                            quizNotifier.nextQuestion();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
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
                        style: AppTypography.labelMd(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        !quizState.isAnswerSubmitted
                            ? Icons.arrow_forward_rounded
                            : (quizState.isLastQuestion
                                ? Icons.celebration_rounded
                                : Icons.arrow_forward_rounded),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
