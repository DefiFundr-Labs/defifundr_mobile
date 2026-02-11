import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ConfettiWrapper extends StatefulWidget {
  final Widget child;
  final bool autoStart;
  final Duration duration;
  final int particleIntensity;
  final bool shouldLoop;
  final List<Color>? customColors;

  const ConfettiWrapper({
    super.key,
    required this.child,
    this.autoStart = true,
    this.duration = const Duration(seconds: 3),
    this.particleIntensity = 1000, 
    this.shouldLoop = false,
    this.customColors,
  });

  @override
  State<ConfettiWrapper> createState() => _ConfettiWrapperState();
}

class _ConfettiWrapperState extends State<ConfettiWrapper> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: widget.duration);

    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  /// Method to manually trigger confetti
  void playConfetti() {
    _confettiController.play();
  }

  /// Method to stop confetti
  void stopConfetti() {
    _confettiController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main child content
        widget.child,

        // Confetti overlay
        _buildConfettiOverlay(context),
      ],
    );
  }

  Widget _buildConfettiOverlay(BuildContext context) {
    final colors = widget.customColors ?? _getDefaultColors(context);

    return Stack(
      children: [
        // Left side confetti
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 4, // 45 degrees
            blastDirectionality: BlastDirectionality.directional,
            particleDrag: 0.02,
            emissionFrequency: 0.005,
            numberOfParticles: (widget.particleIntensity * 0.4).round(),
            gravity: 0.05,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),

        // Right side confetti
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 3 * pi / 4, // 135 degrees
            blastDirectionality: BlastDirectionality.directional,
            particleDrag: 0.02,
            emissionFrequency: 0.005,
            numberOfParticles: (widget.particleIntensity * 0.4).round(),
            gravity: 0.05,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),

        // Center top confetti (main burst)
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2, // 90 degrees (downward)
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.02,
            emissionFrequency: 0.001,
            numberOfParticles: (widget.particleIntensity * 0.6).round(),
            gravity: 0.05,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),

        // Additional left center confetti
        Align(
          alignment: Alignment.centerLeft,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 6, // 30 degrees
            blastDirectionality: BlastDirectionality.directional,
            particleDrag: 0.03,
            emissionFrequency: 0.01,
            numberOfParticles: (widget.particleIntensity * 0.25).round(),
            gravity: 0.06,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 1,
            strokeColor: Colors.white,
          ),
        ),

        // Additional right center confetti
        Align(
          alignment: Alignment.centerRight,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 5 * pi / 6, // 150 degrees
            blastDirectionality: BlastDirectionality.directional,
            particleDrag: 0.03,
            emissionFrequency: 0.01,
            numberOfParticles: (widget.particleIntensity * 0.25).round(),
            gravity: 0.06,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 1,
            strokeColor: Colors.white,
          ),
        ),

        // Omnidirectional burst from center
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 0,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.01,
            emissionFrequency: 0.001,
            numberOfParticles: (widget.particleIntensity * 0.8).round(),
            gravity: 0.03,
            shouldLoop: widget.shouldLoop,
            colors: colors,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),
      ],
    );
  }

  List<Color> _getDefaultColors(BuildContext context) {
    return [
      context.theme.colors.constantDefault,
      context.theme.colors.bgB0,
      Colors.grey,
      context.theme.colors.constantDefaultBorder,
      context.theme.colors.brandContrast,
      Colors.white,
      const Color(0xFFE0E0E0),
      const Color(0xFFBDBDBD),
      const Color(0xFF9E9E9E),
      const Color(0xFFF5F5F5),
    ];
  }
}

/// Extension to provide easy access to confetti controls
extension ConfettiControl on GlobalKey<_ConfettiWrapperState> {
  void playConfetti() {
    currentState?.playConfetti();
  }

  void stopConfetti() {
    currentState?.stopConfetti();
  }
}
