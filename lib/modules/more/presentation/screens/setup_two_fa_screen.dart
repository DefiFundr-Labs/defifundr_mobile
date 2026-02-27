import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SetupTwoFaScreen extends StatelessWidget {
  const SetupTwoFaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    const Spacer(),
                    _buildIcon(context),
                    SizedBox(height: 32.h),
                    Text(
                      l10n.setupTwoFaTitle,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      l10n.setupTwoFaSubtitle,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: PrimaryButton(
                text: l10n.activateNow,
                isEnabled: true,
                onPressed: () =>
                    context.router.push(const SetupInstructionsRoute()),
              ),
            ),
            SizedBox(
                height: MediaQuery.systemGestureInsetsOf(context).bottom + 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.arrowBack,
            colorFilter:
                ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colors = context.theme.colors;
    return Container(
      width: 96.w,
      height: 96.w,
      decoration: BoxDecoration(
        color: colors.brandFill,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          Assets.icons.shieldStar,
          width: 52.w,
          height: 52.w,
          colorFilter:
              ColorFilter.mode(colors.brandDefault, BlendMode.srcIn),
        ),
      ),
    );
  }
}
