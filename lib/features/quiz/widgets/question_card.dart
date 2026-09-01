import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/image_service.dart';

class QuestionCard extends StatelessWidget {
  final String prompt;
  final String? imageKeyword;
  final String subject;

  const QuestionCard({
    super.key,
    required this.prompt,
    this.imageKeyword,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrls = ImageService.getEducationalImageUrls(
      imageKeyword,
      subject,
      questionPrompt: prompt,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
          // Prompt Text
          Text(
            prompt,
            style: AppTypography.headlineLg(color: AppColors.onSurface)
                .copyWith(fontSize: 22, height: 1.3),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),

          // Contextual Educational Image Container
          ResilientEducationalImage(
            imageUrls: imageUrls,
            subject: subject,
            topicKeyword: imageKeyword,
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

