import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/gen/fonts.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome! 👋🏾',
              style: fonts.textMdMedium.copyWith(
                color: colors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
            Text(
              userName,
              style: fonts.heading3SemiBold.copyWith(
                color: colors.textPrimary,
                fontFamily: FontFamily.hankenGrotesk,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.router.push(const NotificationsRoute());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              Assets.icons.alarmNotification,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
