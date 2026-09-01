import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/providers/app_providers.dart';
import 'about_modal.dart';

class SettingsModal extends ConsumerStatefulWidget {
  const SettingsModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsModal(),
    );
  }

  @override
  ConsumerState<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends ConsumerState<SettingsModal> {
  late TextEditingController _nameController;
  late TextEditingController _apiKeyController;
  late TextEditingController _backupKeyController;

  @override
  void initState() {
    super.initState();
    final userRepo = ref.read(userRepositoryProvider);
    final storage = ref.read(storageServiceProvider);

    _nameController = TextEditingController(text: userRepo.getStudentName());
    _apiKeyController = TextEditingController(text: storage.getCustomApiKey() ?? '');
    _backupKeyController = TextEditingController(text: storage.getCustomBackupApiKey() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _apiKeyController.dispose();
    _backupKeyController.dispose();
    super.dispose();
  }

  void _saveSettings() async {
    final name = _nameController.text.trim();
    final apiKey = _apiKeyController.text.trim();
    final backupKey = _backupKeyController.text.trim();

    if (name.isNotEmpty) {
      await ref.read(userProfileProvider.notifier).updateName(name);
      ref.read(studentNameProvider.notifier).state = name;
    }

    final storage = ref.read(storageServiceProvider);
    if (apiKey.isNotEmpty) {
      await storage.saveCustomApiKey(apiKey);
    }
    if (backupKey.isNotEmpty) {
      await storage.saveCustomBackupApiKey(backupKey);
    }

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings saved successfully!'),
          backgroundColor: AppColors.tertiaryContainer,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 24 + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.settings_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Text('Student Settings', style: AppTypography.headlineMd()),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                  tooltip: 'About BrightSpark',
                  onPressed: () {
                    Navigator.of(context).pop();
                    AboutModal.show(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Student Name Field
            Text('Student Name', style: AppTypography.labelMd()),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter student name...',
                prefixIcon: Icon(Icons.person_rounded, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 20),

            // AI Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryFixed),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gemini AI Engine Active',
                            style: AppTypography.labelMd(color: AppColors.primary)),
                        const SizedBox(height: 2),
                        Text(
                          'Dual-key automatic fallback enabled for unlimited K-12 quizzes.',
                          style: AppTypography.bodyMd(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Optional Custom Gemini API Key
            Text('Custom Gemini API Key (Optional)', style: AppTypography.labelMd()),
            const SizedBox(height: 8),
            TextField(
              controller: _apiKeyController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Primary API Key...',
                prefixIcon: Icon(Icons.key_rounded, color: AppColors.secondary),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _backupKeyController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Secondary / Backup API Key...',
                prefixIcon: Icon(Icons.vpn_key_outlined, color: AppColors.outline),
              ),
            ),
            const SizedBox(height: 20),

            // About BrightSpark Tile
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.of(context).pop();
                AboutModal.show(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('About BrightSpark Self-Review', style: AppTypography.labelMd()),
                          Text('Version 1.0.0 • Architecture & Features', style: AppTypography.bodyMd(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.outline),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
