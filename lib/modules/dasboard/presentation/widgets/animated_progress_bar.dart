import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  final double progress;
  final Duration animationDuration;
  final Color? backgroundColor;
  final Color? topColor;
  final double height;
  final bool showPercentage;

  const AnimatedProgressBar({
    Key? key,
    required this.progress,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.backgroundColor,
    this.topColor,
    this.height = 60.0,
    this.showPercentage = true,
  }) : super(key: key);

  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  context.theme.colors.graySecondary.withAlpha(60),
              borderRadius: BorderRadius.circular(widget.height / 2),
            ),
          ),

          // Animated progress
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: _animation.value,
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.topColor ?? context.theme.colors.activeButton,
                    borderRadius: BorderRadius.circular(widget.height / 2),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.topColor ?? Color(0xFF6366F1))
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Percentage text
          if (widget.showPercentage)
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Text(
                      '${(_animation.value * 100).round()}%',
                      style: TextStyle(
                        fontSize: widget.height * 0.4,
                        fontWeight: FontWeight.bold,
                        color: _animation.value > 0.1
                            ? Colors.white
                            : Colors.black87,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
