import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GlassBottomSheet extends StatefulWidget {
  final Widget child;
  final double? height;
  final bool isDismissible;
  final bool enableDrag;
  final Color? backgroundColor;
  final double blurIntensity;
  final double glassOpacity;

  const GlassBottomSheet({
    Key? key,
    required this.child,
    this.height,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.blurIntensity = 15.0,
    this.glassOpacity = 0.2,
  }) : super(key: key);

  @override
  State<GlassBottomSheet> createState() => _GlassBottomSheetState();
}

class _GlassBottomSheetState extends State<GlassBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _liquidController;
  Offset _touchPosition = const Offset(200, 100);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _liquidController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _liquidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_animationController, _liquidController]),
      builder: (context, child) {
        return GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _touchPosition = details.localPosition;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: widget.blurIntensity,
                  sigmaY: widget.blurIntensity,
                ),
                child: CustomPaint(
                  painter: LiquidGlassPainter(
                    animation: _liquidController.value,
                    slideAnimation: _animationController.value,
                    touchPosition: _touchPosition,
                    glassOpacity: widget.glassOpacity,
                  ),
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(widget.glassOpacity + 0.1),
                          Colors.white.withOpacity(widget.glassOpacity),
                          Colors.white.withOpacity(widget.glassOpacity - 0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 8),
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Flexible(child: widget.child),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LiquidGlassPainter extends CustomPainter {
  final double animation;
  final double slideAnimation;
  final Offset touchPosition;
  final double glassOpacity;

  LiquidGlassPainter({
    required this.animation,
    required this.slideAnimation,
    required this.touchPosition,
    required this.glassOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ripplePaint = Paint()
      ..shader = ui.Gradient.radial(
        touchPosition,
        80 + 30 * math.sin(animation * math.pi * 2),
        [
          Colors.white.withOpacity(glassOpacity + 0.2),
          Colors.white.withOpacity(glassOpacity),
          Colors.transparent,
        ],
        [0.0, 0.6, 1.0],
        TileMode.clamp,
      );

    canvas.drawCircle(touchPosition, 60, ripplePaint);

    for (int i = 0; i < 6; i++) {
      final angle = (i / 6) * math.pi * 2 + animation * math.pi * 2;
      final radius = 30 + 10 * math.sin(animation * math.pi * 2 + i);
      final offset = Offset(
        touchPosition.dx + radius * math.cos(angle),
        touchPosition.dy + radius * math.sin(angle),
      );

      final orbPaint = Paint()
        ..color = Colors.white.withOpacity(glassOpacity * 0.8)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 3);

      canvas.drawCircle(
          offset, 8 + 3 * math.sin(animation * math.pi * 4 + i), orbPaint);
    }

    final highlightPaint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, size.height * 0.3),
        [
          Colors.white.withOpacity(0.4 * slideAnimation),
          Colors.transparent,
        ],
        [0.0, 1.0],
        TileMode.clamp,
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.3),
        const Radius.circular(24),
      ),
      highlightPaint,
    );

    final leftReflection = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width * 0.1, 0),
        [
          Colors.white.withOpacity(0.3 * slideAnimation),
          Colors.transparent,
        ],
        [0.0, 1.0],
        TileMode.clamp,
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.05, size.height),
      leftReflection,
    );

    final rightReflection = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width, 0),
        Offset(size.width * 0.9, 0),
        [
          Colors.white.withOpacity(0.3 * slideAnimation),
          Colors.transparent,
        ],
        [0.0, 1.0],
        TileMode.clamp,
      );

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.95, 0, size.width * 0.05, size.height),
      rightReflection,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

void showGlassBottomSheet({
  required BuildContext context,
  required Widget child,
  double? height,
  bool isDismissible = true,
  bool enableDrag = true,
  double blurIntensity = 15.0,
  double glassOpacity = 0.2,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: true,
    builder: (context) => GlassBottomSheet(
      height: height,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      blurIntensity: blurIntensity,
      glassOpacity: glassOpacity,
      child: child,
    ),
  );
}

class AdvancedGlassBottomSheet extends StatefulWidget {
  final Widget child;
  final double? height;
  final bool hasHandle;
  final bool isScrollable;
  final double cornerRadius;

  const AdvancedGlassBottomSheet({
    Key? key,
    required this.child,
    this.height,
    this.hasHandle = true,
    this.isScrollable = false,
    this.cornerRadius = 24,
  }) : super(key: key);

  @override
  State<AdvancedGlassBottomSheet> createState() =>
      _AdvancedGlassBottomSheetState();
}

class _AdvancedGlassBottomSheetState extends State<AdvancedGlassBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  Offset _interactionPoint = const Offset(200, 100);

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _interactionPoint = details.localPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _interactionPoint = details.localPosition;
        });
      },
      child: AnimatedBuilder(
        animation: _shimmerController,
        builder: (context, child) {
          return Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget.cornerRadius),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget.cornerRadius),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: CustomPaint(
                  painter: AdvancedGlassPainter(
                    shimmerAnimation: _shimmerController.value,
                    interactionPoint: _interactionPoint,
                    cornerRadius: widget.cornerRadius,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(widget.cornerRadius),
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.25),
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.hasHandle)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(2.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        widget.isScrollable
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: widget.child,
                                ),
                              )
                            : Flexible(child: widget.child),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdvancedGlassPainter extends CustomPainter {
  final double shimmerAnimation;
  final Offset interactionPoint;
  final double cornerRadius;

  AdvancedGlassPainter({
    required this.shimmerAnimation,
    required this.interactionPoint,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(-size.width, 0),
        Offset(size.width * 2, size.height),
        [
          Colors.transparent,
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(
          size.width * 2 * shimmerAnimation - size.width,
          0,
          0,
        ).storage,
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(cornerRadius),
      ),
      shimmerPaint,
    );

    final glowPaint = Paint()
      ..shader = ui.Gradient.radial(
        interactionPoint,
        100,
        [
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.1),
          Colors.transparent,
        ],
        [0.0, 0.5, 1.0],
        TileMode.clamp,
      );

    canvas.drawCircle(interactionPoint, 80, glowPaint);

    for (int i = 0; i < 4; i++) {
      final dropPaint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 2);

      final x = (i / 4) * size.width +
          20 * math.sin(shimmerAnimation * math.pi * 2 + i);
      final y = 20 + 10 * math.cos(shimmerAnimation * math.pi * 2 + i);

      canvas.drawCircle(Offset(x, y), 3, dropPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GlassBottomSheetDemo extends StatelessWidget {
  const GlassBottomSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showGlassBottomSheet(
                    context: context,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Glass Bottom Sheet',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'This is a liquid glass effect bottom sheet. Touch and drag to see the interactive effects!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.white.withOpacity(0.8)),
                              Icon(Icons.favorite,
                                  color: Colors.white.withOpacity(0.8)),
                              Icon(Icons.thumb_up,
                                  color: Colors.white.withOpacity(0.8)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Show Basic Glass Sheet'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => AdvancedGlassBottomSheet(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const Text(
                              'Advanced Glass Sheet',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: const Text(
                                'Enhanced with shimmer effects, interactive glow, and liquid drop animations. Tap anywhere to see the magic!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 12,
                              children: [
                                Chip(
                                  label: const Text('Interactive'),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                Chip(
                                  label: const Text('Animated'),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                Chip(
                                  label: const Text('Glass Effect'),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Show Advanced Glass Sheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
