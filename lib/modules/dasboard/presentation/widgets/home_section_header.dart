import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: fonts.textMdSemiBold.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        TextButton(
          onPressed: onSeeAll ?? () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(4.sp),
            splashFactory: NoSplash.splashFactory,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            children: [
              Text(
                'See all',
                style: fonts.textSmSemiBold.copyWith(
                  color: colors.brandDefault,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SvgPicture.asset(
                Assets.icons.caretRightSvg,
                height: 13.h,
                width: 12.w,
                colorFilter: ColorFilter.mode(
                  colors.brandDefault,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeEmptyState extends StatelessWidget {
  final String imagePath;
  final String message;

  const HomeEmptyState({
    super.key,
    required this.imagePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 48,
            height: 48,
            colorFilter: ColorFilter.mode(
              colors.textTertiary.withAlpha(120),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
