import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class QuestionCard extends StatelessWidget {
  final String prompt;
  final int questionIndex;

  const QuestionCard({
    super.key,
    required this.prompt,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final mascotPoseAsset = AppAssets.getMascotPose(questionIndex);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 3D Mascot Pose Companion
          Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                mascotPoseAsset,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.2),
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.smart_toy_rounded,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Prompt Text
          Text(
            prompt,
            style: AppTypography.headlineLg(color: AppColors.onSurface)
                .copyWith(fontSize: 20, height: 1.35),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}



class ResilientEducationalImage extends StatefulWidget {
  final List<String> imageUrls;
  final String subject;
  final String? topicKeyword;

  const ResilientEducationalImage({
    super.key,
    required this.imageUrls,
    required this.subject,
    this.topicKeyword,
  });

  @override
  State<ResilientEducationalImage> createState() => _ResilientEducationalImageState();
}

class _ResilientEducationalImageState extends State<ResilientEducationalImage> {
  int _currentIndex = 0;
  bool _useAssetFallback = false;

  @override
  void didUpdateWidget(covariant ResilientEducationalImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrls != widget.imageUrls) {
      _currentIndex = 0;
      _useAssetFallback = false;
    }
  }

  void _onImageError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_currentIndex + 1 < widget.imageUrls.length) {
        setState(() {
          _currentIndex++;
        });
      } else {
        setState(() {
          _useAssetFallback = true;
        });
      }
    });
  }

  void _showZoomedImage(BuildContext context, String? currentUrl) {
    if (currentUrl == null || _useAssetFallback) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                currentUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildThemedFallback(),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemedFallback() {
    final sub = widget.subject.toLowerCase();
    final IconData icon;
    final Color color;
    final String label;

    if (sub.contains('science')) {
      icon = Icons.biotech_rounded;
      color = AppColors.primary;
      label = widget.topicKeyword?.toUpperCase() ?? 'SCIENCE VISUAL';
    } else if (sub.contains('math')) {
      icon = Icons.calculate_rounded;
      color = Colors.deepOrange;
      label = widget.topicKeyword?.toUpperCase() ?? 'MATHEMATICS CONCEPT';
    } else if (sub.contains('history') || sub.contains('philippine')) {
      icon = Icons.account_balance_rounded;
      color = AppColors.secondary;
      label = widget.topicKeyword?.toUpperCase() ?? 'HISTORICAL TOPIC';
    } else {
      icon = Icons.auto_stories_rounded;
      color = AppColors.tertiaryContainer;
      label = widget.topicKeyword?.toUpperCase() ?? 'LANGUAGE ARTS';
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: AppTypography.labelSm(color: color).copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeUrl = (!_useAssetFallback && widget.imageUrls.isNotEmpty)
        ? widget.imageUrls[_currentIndex]
        : null;

    return GestureDetector(
      onTap: () => _showZoomedImage(context, activeUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: _useAssetFallback || activeUrl == null
              ? _buildThemedFallback()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      activeUrl,
                      key: ValueKey(activeUrl),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.surfaceContainerHigh,
                          child: const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        _onImageError();
                        return _buildThemedFallback();
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.zoom_in_rounded,
                          color: Colors.white,
                          size: 20,
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

