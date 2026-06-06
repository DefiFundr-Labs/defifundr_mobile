import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? icon;
  final Color? iconBackgroundColor;

  const SuccessBottomSheet({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? context.theme.colors.brandFill,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.icons.calendarSlash,
                  width: 32.w,
                  height: 32.h,
                  colorFilter: ColorFilter.mode(
                    context.theme.colors.brandDefault,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: context.theme.fonts.heading2Bold.copyWith(
                color: context.theme.colors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            PrimaryButton(
              onPressed: () {
                context.router.maybePop();
                context.router.maybePop();
              },
              text: 'Done',
            ),
          ],
        ),
      ),
    );
  }
}
