import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/models/quiz_session_model.dart';
import '../../core/providers/app_providers.dart';
import '../result/result_screen.dart';

class QuizHistoryScreen extends ConsumerWidget {
  const QuizHistoryScreen({super.key});

  Future<void> _deleteItem(
    BuildContext context,
    WidgetRef ref,
    QuizSessionResult item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Delete Quiz Record?'),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this Grade ${item.grade} • ${item.subject.displayName} quiz session? This action cannot be undone.',
          style: AppTypography.bodyMd(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: AppTypography.labelMd(color: AppColors.onSurfaceVariant)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(quizHistoryProvider.notifier).deleteResult(item.id);
      ref.read(userProfileProvider.notifier).refresh();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Quiz session deleted from history.'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _clearAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_sweep_rounded, color: AppColors.error, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Clear All History?'),
            ),
          ],
        ),
        content: Text(
          'This will permanently delete all completed quiz sessions from your history and reset your aggregate stats.',
          style: AppTypography.bodyMd(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: AppTypography.labelMd(color: AppColors.onSurfaceVariant)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(quizHistoryProvider.notifier).clearAll();
      ref.read(userProfileProvider.notifier).refresh();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('All quiz history has been cleared.'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(quizHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Quiz History',
          style: AppTypography.headlineMd(color: AppColors.primary),
        ),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.onSurfaceVariant),
              tooltip: 'Clear All History',
              onPressed: () => _clearAll(context, ref),
            ),
        ],
      ),
      body: SafeArea(
        child: history.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainer,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.quiz_outlined,
                          size: 44,
                          color: AppColors.outline,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Quiz History Yet',
                        style: AppTypography.headlineMd(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Complete a self-review session on the Learn tab to see your progress and past scores here!',
                        style: AppTypography.bodyMd(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: history.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = history[index];
                  final dateFormat = DateFormat('MMM d, y • h:mm a');
                  final dateStr = dateFormat.format(item.completedAt);
                  final isPassed = item.score >= 10;

                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      await _deleteItem(context, ref, item);
                      return false; // delete is handled explicitly in _deleteItem
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.errorContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: AppColors.onErrorContainer,
                      ),
                    ),
                    child: Container(
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
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: item.subject.containerColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            item.subject.iconData,
                            color: item.subject.iconColor,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          'Grade ${item.grade} • ${item.subject.displayName}',
                          style: AppTypography.labelMd(),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(
                              dateStr,
                              style: AppTypography.bodyMd().copyWith(fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: item.difficulty.cardBgColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Difficulty: ${item.difficulty.title}',
                                style: AppTypography.labelSm(
                                  color: item.difficulty.accentColor,
                                ).copyWith(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${item.score}/${item.totalQuestions}',
                                  style: AppTypography.headlineMd(
                                    color: isPassed
                                        ? AppColors.tertiaryContainer
                                        : AppColors.error,
                                  ).copyWith(fontSize: 18),
                                ),
                                Text(
                                  '${item.percentage.toStringAsFixed(0)}%',
                                  style: AppTypography.labelSm(
                                    color: isPassed
                                        ? AppColors.tertiaryContainer
                                        : AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.outline,
                                size: 20,
                              ),
                              tooltip: 'Delete',
                              onPressed: () => _deleteItem(context, ref, item),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(result: item),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
