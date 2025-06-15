import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? icon;
  final double fontSize;

  const SmallButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor,
    this.fontSize = 16,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return SizedBox(
      width: width ?? 159.5,
      height: 48,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.brandDefaultContrast,
          foregroundColor: Colors.white,
          disabledBackgroundColor: colors.inactiveButton,
          disabledForegroundColor: colors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2.0,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: fonts.textBaseSemiBold.copyWith(
                        color: textColor ?? Colors.white,
                        fontFamily: 'Inter',
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
