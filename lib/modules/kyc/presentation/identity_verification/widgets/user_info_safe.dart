import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

class UserInfoSafeCard extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String description;

  const UserInfoSafeCard({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: resolveColor(
          context: context,
          lightColor: context.theme.colors.bgB0,
          darkColor: context.theme.colors.bgB0,
        ),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: context.theme.colors.strokeSecondary, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 1,
            spreadRadius: -5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.theme.fonts.textMdSemiBold),
                SizedBox(height: 1),
                Text(description, style: context.theme.fonts.textSmRegular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
