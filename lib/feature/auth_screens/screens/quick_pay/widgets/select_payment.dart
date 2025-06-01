import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          color: AppColors.bgB1Base,
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
                style: (const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
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
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.grayTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
