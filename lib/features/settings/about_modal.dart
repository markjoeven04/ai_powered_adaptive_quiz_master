import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';

class AboutModal extends StatelessWidget {
  const AboutModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AboutModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 32),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo with ambient glow
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      AppAssets.logoSpark,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.lightbulb_rounded,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // App Title & Version Tag
                  Text(
                    '${AppStrings.appName} ${AppStrings.appSubtitle}',
                    style: AppTypography.headlineLg(color: AppColors.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Version 1.0.0 • AI-Powered K-12 Learning',
                      style: AppTypography.labelSm(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // App Mission & Overview Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.school_rounded, color: AppColors.primary, size: 22),
                            const SizedBox(width: 8),
                            Text('About the Platform', style: AppTypography.headlineMd()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bright Spark Quiz Master is an intelligent, gamified learning companion engineered for K-12 students. It transforms self-directed study into an interactive adventure with real-time adaptive questions tailored to each learner\'s grade level, subject mastery, and pace.',
                          style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Key Capabilities
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Core Features', style: AppTypography.headlineMd()),
                        const SizedBox(height: 14),
                        _buildFeatureRow(
                          icon: Icons.psychology_rounded,
                          color: AppColors.primary,
                          title: 'Adaptive AI Engine',
                          description: 'Dynamically scales question difficulty based on student performance using advanced AI.',

                        ),
                        const SizedBox(height: 12),
                        _buildFeatureRow(
                          icon: Icons.menu_book_rounded,
                          color: AppColors.tertiaryContainer,
                          title: 'Comprehensive K-12 Curriculum',
                          description: 'Full support across Primary (G1-3), Intermediate (G4-6), Junior High (G7-10), and Senior High (G11-12).',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureRow(
                          icon: Icons.lightbulb_outline_rounded,
                          color: AppColors.secondary,
                          title: 'Instant Pedagogical Feedback',
                          description: 'Detailed concept explanations after every answer to help students learn from mistakes.',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureRow(
                          icon: Icons.offline_bolt_rounded,
                          color: Colors.deepOrange,
                          title: 'Offline-Ready Intelligence',
                          description: 'Built-in offline curriculum repository ensures study sessions are never interrupted.',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureRow(
                          icon: Icons.emoji_events_rounded,
                          color: AppColors.secondary,
                          title: 'Gamified Achievements',
                          description: 'Earn badges, maintain learning streaks, and track subject mastery over time.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lead Developer & Creator Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryContainer.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryContainer],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.code_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lead Developer & Creator',
                                style: AppTypography.labelSm(color: AppColors.primary),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Mark Joeven Orpilla',
                                style: AppTypography.headlineMd().copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Architecture, AI Integration & Flutter Engineering',
                                style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Close Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Got It!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.labelMd()),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
