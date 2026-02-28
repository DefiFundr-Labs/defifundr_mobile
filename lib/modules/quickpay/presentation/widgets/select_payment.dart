import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class SelectPayment extends StatelessWidget {
  final String title;
  final String? label;
  final String? iconUrl;
  final String? trailingImagePath;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;

  const SelectPayment({
    super.key,
    required this.title,
    this.label,
    this.iconUrl,
    this.trailingImagePath,
    this.titleStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: resolveColor(
            context: context,
            lightColor: AppColors.bgB1Base,
            darkColor: AppColorDark.bgB1Base,
          ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null) ...[
                    Text(
                      label!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textSecondary,
                          darkColor: AppColorDark.textSecondary,
                        ),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    title,
                    style: (TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: resolveColor(
                        context: context,
                        lightColor: AppColors.textSecondary,
                        darkColor: AppColorDark.textSecondary,
                      ),
                      fontFamily: 'Inter',
                    )).copyWith(
                      fontSize: titleStyle?.fontSize,
                      fontWeight: titleStyle?.fontWeight,
                      color: titleStyle?.color,
                      fontFamily: titleStyle?.fontFamily,
                      letterSpacing: titleStyle?.letterSpacing,
                      height: titleStyle?.height,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (trailingImagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  trailingImagePath!,
                  width: 32,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: resolveColor(
                      context: context,
                      lightColor: AppColors.grayTertiary,
                      darkColor: AppColorDark.grayTertiary,
                    ),
                  ),
                ),
              )
            else
              Icon(
                Icons.arrow_forward_ios,
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
