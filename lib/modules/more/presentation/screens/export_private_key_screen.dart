// ignore_for_file: deprecated_member_use

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
class ExportPrivateKeyScreen extends StatelessWidget {
  final String walletAddress;

  const ExportPrivateKeyScreen({
    super.key,
    required this.walletAddress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      context.l10n.exportPrivateKey,
                      style: fonts.heading2Bold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.l10n.exportPrivateKeySubtitle,
                      style: fonts.textBaseRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildWarningCard(
                      context: context,
                      colors: colors,
                      fonts: fonts,
                      isLightMode: isLightMode,
                      iconPath: Assets.icons.deviceMobile,
                      title: context.l10n.keepScreenPrivateTitle,
                      description:
                          context.l10n.keepScreenPrivateDesc,
                    ),
                    SizedBox(height: 16.h),
                    _buildWarningCard(
                      context: context,
                      colors: colors,
                      fonts: fonts,
                      isLightMode: isLightMode,
                      iconPath: Assets.icons.shieldCheckered,
                      title: context.l10n.storeKeysOfflineTitle,
                      description:
                          context.l10n.storeKeysOfflineDesc,
                    ),
                    SizedBox(height: 16.h),
                    _buildWarningCard(
                      context: context,
                      colors: colors,
                      fonts: fonts,
                      isLightMode: isLightMode,
                      iconPath: Assets.icons.key,
                      title: context.l10n.yourKeyYourWalletTitle,
                      description:
                          context.l10n.yourKeyYourWalletDesc,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: context.l10n.revealPrivateKey,
                onPressed: () {
                  context.router.push(
                    PrivateKeyRoute(
                      walletAddress: walletAddress,
                      privateKey:
                          'C524b945DDB20f703338f4696102D10bbC12629C0xC524b945DDB20f703338f4696102D10bbC12629C',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningCard({
    required BuildContext context,
    required dynamic colors,
    required dynamic fonts,
    required bool isLightMode,
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: colors.brandFill,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 22.w,
                height: 22.w,
                colorFilter: ColorFilter.mode(
                  colors.brandDefault,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: fonts.textBaseSemiBold.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: fonts.textSmRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
