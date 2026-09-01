import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/providers/app_providers.dart';

class RankScreen extends ConsumerWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final studentName = profile.name.isEmpty ? 'Student' : profile.name;

    final mockLeaderboard = [
      {'rank': 1, 'name': 'Sofia M.', 'grade': 'Grade 6', 'score': 390, 'badge': '🥇'},
      {'rank': 2, 'name': 'Ethan R.', 'grade': 'Grade 10', 'score': 365, 'badge': '🥈'},
      {'rank': 3, 'name': 'Chloe T.', 'grade': 'Grade 8', 'score': 340, 'badge': '🥉'},
      {'rank': 4, 'name': studentName, 'grade': 'You', 'score': profile.totalScore > 0 ? profile.totalScore : 120, 'badge': '⭐', 'isMe': true},
      {'rank': 5, 'name': 'Liam B.', 'grade': 'Grade 4', 'score': 95, 'badge': '🎖️'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Rank & Leaderboard',
          style: AppTypography.headlineMd(color: AppColors.primary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Stats Summary Card
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
                      color: AppColors.primary.withValues(alpha: 0.3),
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
                            Icons.person_rounded,
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
                                'Rank #4 • Master Scholar',
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
                              const Icon(Icons.local_fire_department_rounded,
                                  color: AppColors.onSecondaryContainer, size: 18),
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
                        _buildStatItem('Quizzes', '${profile.totalQuizzes}'),
                        _buildStatItem('Total Score', '${profile.totalScore}'),
                        _buildStatItem('Badges', '${profile.unlockedBadgeIds.length}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Leaderboard Title
              Text(
                'Weekly Top Scholars',
                style: AppTypography.headlineMd(color: AppColors.onSurface),
              ),
              const SizedBox(height: 14),

              // Leaderboard List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mockLeaderboard.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final entry = mockLeaderboard[index];
                  final isMe = entry['isMe'] == true;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppColors.primaryFixed.withValues(alpha: 0.4)
                          : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isMe ? AppColors.primary : AppColors.surfaceContainer,
                        width: isMe ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${entry['badge']}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry['name']}',
                                style: AppTypography.labelMd(
                                  color: isMe ? AppColors.primary : AppColors.onSurface,
                                ),
                              ),
                              Text(
                                '${entry['grade']}',
                                style: AppTypography.bodyMd().copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${entry['score']} pts',
                          style: AppTypography.labelMd(
                            color: isMe ? AppColors.primary : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
