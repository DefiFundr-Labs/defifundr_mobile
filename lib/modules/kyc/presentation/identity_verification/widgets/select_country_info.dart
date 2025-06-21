import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class SelectCountryInfo extends StatelessWidget {
  final String svgAsset;
  final String title;
  final VoidCallback? onTap;
  final bool svgHasColor;

  const SelectCountryInfo({
    super.key,
    required this.svgAsset,
    required this.title,
    this.onTap,
    this.svgHasColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: resolveColor(
                context: context,
                lightColor:
                    context.theme.colors.fillTertiary.withValues(alpha: 0.04),
                darkColor:
                    context.theme.colors.fillTertiary.withValues(alpha: 0.04),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgAsset,
                  width: 24,
                  height: 24,
                  colorFilter: svgHasColor
                      ? ColorFilter.mode(
                          resolveColor(
                            context: context,
                            lightColor: AppColors.textPrimary,
                            darkColor: AppColorDark.textPrimary,
                          ),
                          BlendMode.srcIn,
                        )
                      : null,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(title, style: context.theme.fonts.textMdSemiBold),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: context.theme.colors.contrastBlack,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
