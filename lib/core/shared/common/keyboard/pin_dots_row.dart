import 'package:defifundr_mobile/core/shared/common/keyboard/pin_dot.dart';
import 'package:flutter/material.dart';

class PinDotsRow extends StatelessWidget {
  final int pinLength;
  final int currentPinLength;
  final bool hasError;
  final Animation<double> shakeAnimation;
  final double dotSize;
  final double spacing;

  const PinDotsRow({
    super.key,
    required this.pinLength,
    required this.currentPinLength,
    required this.hasError,
    required this.shakeAnimation,
    this.dotSize = 64,
    this.spacing = 22,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            shakeAnimation.value *
                8 *
                (0.5 - ((shakeAnimation.value * 4) % 1)).abs(),
            0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pinLength,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index < pinLength - 1 ? spacing : 0,
                ),
                child: PinDot(
                  isFilled: index < currentPinLength,
                  hasError: hasError,
                  size: dotSize,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
