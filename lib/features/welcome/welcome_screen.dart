import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../core/models/subject_enum.dart';
import '../../core/providers/app_providers.dart';
import '../grade_level/grade_level_screen.dart';
import '../settings/settings_modal.dart';
import 'widgets/subject_card.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final initialName = ref.read(studentNameProvider);
    _nameController = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onLetGoPressed() {
    final name = _nameController.text.trim();
    final subject = ref.read(selectedSubjectProvider);

    if (name.isEmpty || subject == null) return;

    ref.read(studentNameProvider.notifier).state = name;
    ref.read(userProfileProvider.notifier).updateName(name);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GradeLevelScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSubject = ref.watch(selectedSubjectProvider);
    final hasName = _nameController.text.trim().isNotEmpty;
    final isReady = hasName && selectedSubject != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 20,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 3D Robot Mascot Hero
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: Image.asset(
                      AppAssets.mascotRobot,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.smart_toy_rounded,
                        size: 96,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title & Subtitle
              Text(
                AppStrings.welcomeTitle,
                style: AppTypography.headlineLg(color: AppColors.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                AppStrings.welcomeSubtitle,
                style: AppTypography.bodyLg(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Name Input Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.namePrompt,
                      style: AppTypography.headlineMd(color: AppColors.primary),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      onChanged: (_) => setState(() {}),
                      style: AppTypography.bodyLg(color: AppColors.onSurface),
                      decoration: InputDecoration(
                        hintText: AppStrings.namePlaceholder,
                        suffixIcon: hasName
                            ? const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.tertiaryContainer,
                                size: 24,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Subject Selection Grid
              Text(
                AppStrings.pickFavorites,
                style: AppTypography.headlineMd(color: AppColors.onSurface),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: Subject.values.map((subject) {
                  return SubjectCard(
                    subject: subject,
                    isSelected: selectedSubject == subject,
                    onTap: () {
                      ref.read(selectedSubjectProvider.notifier).state = subject;
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Primary "Let's Go! →" Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isReady ? _onLetGoPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isReady
                        ? AppColors.primary
                        : AppColors.surfaceContainerHigh,
                    foregroundColor: isReady
                        ? AppColors.onPrimary
                        : AppColors.outline,
                    elevation: isReady ? 3 : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.letsGo,
                        style: AppTypography.headlineMd(
                          color: isReady
                              ? AppColors.onPrimary
                              : AppColors.outline,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: isReady
                            ? AppColors.onPrimary
                            : AppColors.outline,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
