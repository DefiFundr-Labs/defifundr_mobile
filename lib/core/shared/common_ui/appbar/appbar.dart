import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/image/image_theme_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DeFiRaiseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? isBack;
  final Widget? leading;
  final bool centerTitle;
  const DeFiRaiseAppBar({
    this.title,
    this.actions,
    this.centerTitle = true,
    this.isBack = false,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor:
          isDark ? context.theme.colors.bgB0 : context.theme.colors.bgB1,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: Text(title ?? '', style: context.textTheme.headlineMedium),
      actions: actions ??
          [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
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
            ),
          ],
      leading: isBack!
          ? IconButton(
              icon: SvgPicture.asset(
                Assets.icons.arrowBack,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                context.pop();
              },
            )
          : leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
