// Action Button Component (for biometric and backspace)
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 72.w,
        height: 72.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon,
            size: size.sp,
            color: context.theme.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
