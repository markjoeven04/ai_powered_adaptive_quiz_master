import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../core/constants/app_colors.dart';

class ConfettiOverlay extends StatefulWidget {
  const ConfettiOverlay({super.key});

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 4));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controller,
        blastDirection: pi / 2, // downwards
        maxBlastForce: 6,
        minBlastForce: 2,
        emissionFrequency: 0.05,
        numberOfParticles: 25,
        gravity: 0.2,
        shouldLoop: false,
        colors: const [
          AppColors.primary,
          AppColors.secondaryContainer,
          AppColors.tertiaryContainer,
          AppColors.secondaryFixed,
          AppColors.primaryFixedDim,
          AppColors.successGreen,
        ],
      ),
    );
  }
}
