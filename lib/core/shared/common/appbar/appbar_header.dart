// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/image/image_theme_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarHeaderWidget extends StatelessWidget {
  const AppBarHeaderWidget({super.key, this.widget, this.isBack});
  final Widget? widget;
  final bool? isBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget ??
            Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: context.theme.colors.contrastBlack,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: const EdgeInsets.all(8),
              child: ThemeAdaptiveImage.colorAdaptive(
                asset: AppAssets.defiFundrLogo,
                width: 14.sp,
                height: 24.sp,
                lightColor: context.theme.colors.contrastWhite,
                darkColor: context.theme.colors.contrastWhite,
              ),
            ),
        Container(
          height: 32.h,
          width: 111.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: context.theme.iconTheme.color!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThemeAdaptiveImage.colorAdaptive(
                asset: Assets.icons.questionSvg,
                width: 14.sp,
                height: 14.sp,
                lightColor: context.theme.colors.contrastBlack,
                darkColor: context.theme.colors.contrastBlack,
              ),
              const SizedBox(width: 4),
              Text('Need Help?', style: context.theme.fonts.textSmMedium),
            ],
          ),
        ),
      ],
    );
  }
}
