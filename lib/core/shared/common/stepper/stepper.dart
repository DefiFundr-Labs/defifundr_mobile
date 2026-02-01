import 'dart:math' as math;

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AnimatedStepProgress extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final double size;
  final Color? progressColor;
  final Color? backgroundColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final double strokeWidth;
  final Duration animationDuration;

  const AnimatedStepProgress({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.size = 32.0,
    this.progressColor,
    this.backgroundColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.strokeWidth = 6.0,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<AnimatedStepProgress> createState() => _AnimatedStepProgressState();
}

class _AnimatedStepProgressState extends State<AnimatedStepProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.currentStep / widget.totalSteps,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void didUpdateWidget(AnimatedStepProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.currentStep / widget.totalSteps,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: CircularStepProgressPainter(
                progress: _progressAnimation.value,
                progressColor:
                    widget.progressColor ?? context.theme.colors.brandDefault,
                backgroundColor: widget.backgroundColor ??
                    context.theme.colors.graySecondary.withAlpha(60),
                strokeWidth: widget.strokeWidth,
              ),
              child: Center(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.currentStep}',
                      style: context.theme.fonts.textBaseSemiBold.copyWith(
                        color: widget.activeTextColor ??
                            context.theme.colors.brandDefault,
                        fontSize: widget.size * 0.40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: '/${widget.totalSteps}',
                      style: context.theme.fonts.textBaseSemiBold.copyWith(
                        color: widget.inactiveTextColor ??
                            context.theme.colors.textSecondary,
                        fontSize: widget.size * 0.30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}

class CircularStepProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularStepProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularStepProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
