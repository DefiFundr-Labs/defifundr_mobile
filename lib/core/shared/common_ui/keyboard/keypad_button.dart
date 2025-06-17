import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeypadButton extends StatefulWidget {
  final String number;
  final VoidCallback onPressed;

  const KeypadButton({
    super.key,
    required this.number,
    required this.onPressed,
  });

  @override
  State<KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<KeypadButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isPressed
                ? context.theme.colors.grayTertiary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              widget.number,
              style: context.theme.fonts.bodyMedium.copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: context.theme.colors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
