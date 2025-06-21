import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class OnboardingCard extends StatelessWidget {
  final String svgAsset;
  final String title;
  final VoidCallback? onTap;
  final bool svgHasColor, isDone;

  const OnboardingCard({
    super.key,
    required this.svgAsset,
    required this.title,
    this.onTap,
    this.svgHasColor = true,
    this.isDone = false,
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
                            lightColor: isDone
                                ? context.theme.colors.textTertiary
                                : AppColors.textPrimary,
                            darkColor: isDone
                                ? context.theme.colors.textTertiary
                                : AppColorDark.textPrimary,
                          ),
                          BlendMode.srcIn,
                        )
                      : null,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(title,
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                          color: isDone
                              ? context.theme.colors.textTertiary
                              : null)),
                ),
                isDone
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                width: 1,
                                color: context.theme.colors.greenStroke),
                            color: context.theme.colors.greenFill),
                        child: Text(
                          "Done",
                          style: context.theme.fonts.textSmBold.copyWith(
                              color: context.theme.colors.greenDefault),
                        ),
                      )
                    : Icon(
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
