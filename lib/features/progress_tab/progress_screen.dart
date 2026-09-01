import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/models/subject_enum.dart';
import '../../core/providers/app_providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final history = ref.watch(quizHistoryProvider);
    final badges = ref.watch(badgesProvider);
    final studentName = profile.name.isEmpty ? 'Scholar' : profile.name;

    // Compute aggregate statistics
    int totalQuestionsAnswered = 0;
    int totalCorrectAnswers = 0;
    for (final item in history) {
      totalQuestionsAnswered += item.totalQuestions;
      totalCorrectAnswers += item.score;
    }
    final overallAccuracy = totalQuestionsAnswered > 0
        ? (totalCorrectAnswers / totalQuestionsAnswered * 100).round()
        : 0;

    final unlockedBadgesCount = badges.where((b) => b.isUnlocked).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Learning Progress',
          style: AppTypography.headlineMd(color: AppColors.primary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Self-Paced Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentName,
                                style: AppTypography.headlineMd(color: Colors.white),
                              ),
                              Text(
                                'Self-Paced Learner • K-12 Reviewer',
                                style: AppTypography.bodyMd(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.onSecondaryContainer,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${profile.streakDays}d Streak',
                                style: AppTypography.labelSm(
                                  color: AppColors.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white24, height: 1),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Quizzes Taken', '${profile.totalQuizzes}'),
                        _buildStatItem('Accuracy', '$overallAccuracy%'),
                        _buildStatItem('Badges', '$unlockedBadgesCount/${badges.length}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Subject Mastery Section
              Text(
                'Subject Mastery',
                style: AppTypography.headlineMd(color: AppColors.onSurface),
              ),
              const SizedBox(height: 6),
              Text(
                'Track your individual proficiency across every K-12 subject at your own pace.',
                style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 14),

              // Subject Cards List
              ...Subject.values.map((subject) {
                final subjectSessions =
                    history.where((s) => s.subject == subject).toList();
                final count = subjectSessions.length;
                int subjectScore = 0;
                int subjectTotal = 0;
                for (final s in subjectSessions) {
                  subjectScore += s.score;
                  subjectTotal += s.totalQuestions;
                }
                final avgPct = subjectTotal > 0
                    ? (subjectScore / subjectTotal * 100).round()
                    : 0;

                final String masteryStatus;
                final Color statusColor;
                if (count == 0) {
                  masteryStatus = 'Not Started';
                  statusColor = AppColors.outline;
                } else if (avgPct >= 90) {
                  masteryStatus = '🏆 Master';
                  statusColor = AppColors.tertiaryContainer;
                } else if (avgPct >= 75) {
                  masteryStatus = '⭐ Proficient';
                  statusColor = AppColors.primary;
                } else if (avgPct >= 50) {
                  masteryStatus = '🌿 Developing';
                  statusColor = AppColors.secondary;
                } else {
                  masteryStatus = '🌱 Practice Needed';
                  statusColor = AppColors.error;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceContainer),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: subject.containerColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              subject.iconData,
                              color: subject.iconColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subject.displayName,
                                  style: AppTypography.labelMd(),
                                ),
                                Text(
                                  count == 0
                                      ? 'No quizzes completed yet'
                                      : '$count ${count == 1 ? 'quiz' : 'quizzes'} completed • $avgPct% avg score',
                                  style: AppTypography.bodyMd().copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              masteryStatus,
                              style: AppTypography.labelSm(color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: count == 0 ? 0.0 : (avgPct / 100).clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: AppColors.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            count == 0 ? AppColors.outline : subject.iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Self-Paced Philosophy & Tips Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.tertiaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.onTertiaryContainer,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Self-Paced Mastery Tip',
                            style: AppTypography.labelMd(color: AppColors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Take your time to understand the explanations after each question. Retake quizzes anytime to strengthen key concepts and unlock mastery badges!',
                            style: AppTypography.bodyMd(
                              color: AppColors.onSurfaceVariant,
                            ).copyWith(fontSize: 13, height: 1.4),
                          ),
                        ],
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
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineLg(color: Colors.white).copyWith(fontSize: 22),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.labelSm(color: Colors.white.withValues(alpha: 0.85)),
        ),
      ],
    );
  }
}
