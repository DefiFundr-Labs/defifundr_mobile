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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: resolveColor(
            context: context,
            lightColor: AppColors.textPrimary.withValues(alpha: 0.04),
            darkColor: AppColorDark.fillTertiary.withValues(alpha: 0.04),
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
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: resolveColor(
                    context: context,
                    lightColor: AppColors.textPrimary,
                    darkColor: AppColorDark.textPrimary,
                  ),
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Right arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
