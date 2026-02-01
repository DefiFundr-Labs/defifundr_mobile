import 'package:defifundr_mobile/core/shared/common/keyboard/pin_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinDotsRow extends StatelessWidget {
  final int pinLength;
  final int currentPinLength;
  final bool hasError;
  final Animation<double> shakeAnimation;

  const PinDotsRow({
    super.key,
    required this.pinLength,
    required this.currentPinLength,
    required this.hasError,
    required this.shakeAnimation,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              pinLength,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index < pinLength - 1 ? 16.w : 0,
                ),
                child: PinDot(
                  isFilled: index < currentPinLength,
                  hasError: hasError,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
