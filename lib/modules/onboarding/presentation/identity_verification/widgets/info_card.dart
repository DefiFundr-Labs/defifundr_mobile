import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String description;
  final VoidCallback? onTap; // 👈 Added onTap

  const InfoCard({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.description,
    this.onTap, // 👈 Constructor support
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 Tap interaction
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: resolveColor(
            context: context,
            lightColor: AppColors.textPrimary.withValues(alpha: .04),
            darkColor: AppColorDark.textPrimary.withValues(alpha: .04),
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
                  lightColor: AppColors.textPrimary,
                  darkColor: AppColorDark.textPrimary,
                ),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: resolveColor(
                        context: context,
                        lightColor: AppColors.textPrimary,
                        darkColor: AppColorDark.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
