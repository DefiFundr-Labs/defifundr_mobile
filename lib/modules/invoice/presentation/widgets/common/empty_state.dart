import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const EmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 200.w,
            height: 200.h,
          ),
          Text(title, style: context.theme.fonts.textMdSemiBold),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: context.theme.fonts.textMdRegular
                  .copyWith(color: context.theme.colors.textSecondary)),
        ],
      ),
    );
  }
}
