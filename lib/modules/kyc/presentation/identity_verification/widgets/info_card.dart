import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.description,
    this.onTap,
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
                lightColor: context.theme.colors.fillTertiary,
                darkColor: context.theme.colors.fillTertiary,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgAsset,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    resolveColor(
                      context: context,
                      lightColor: context.theme.colors.textPrimary,
                      darkColor: context.theme.colors.textPrimary,
                    ),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.theme.fonts.textMdSemiBold),
                      const SizedBox(height: 4),
                      Text(description,
                          style: context.theme.fonts.textMdRegular),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
