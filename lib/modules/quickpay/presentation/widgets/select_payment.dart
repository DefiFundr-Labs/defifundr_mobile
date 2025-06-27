import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class SelectPayment extends StatelessWidget {
  final String title;
  final String? iconUrl;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;

  const SelectPayment({
    super.key,
    required this.title,
    this.iconUrl,
    this.titleStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB0,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (iconUrl != null) ...[
              SvgPicture.asset(
                iconUrl!,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: context.theme.fonts.textMdRegular
                    .copyWith(color: context.theme.colors.textTertiary)
                    .copyWith(
                      fontSize: titleStyle?.fontSize,
                      fontWeight: titleStyle?.fontWeight,
                      color: titleStyle?.color,
                      fontFamily: titleStyle?.fontFamily,
                      letterSpacing: titleStyle?.letterSpacing,
                      height: titleStyle?.height,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: resolveColor(
                context: context,
                lightColor: AppColors.grayTertiary,
                darkColor: AppColorDark.grayTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
