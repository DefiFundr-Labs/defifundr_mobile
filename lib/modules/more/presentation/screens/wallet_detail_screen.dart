// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/utils/pixeled_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class WalletDetailScreen extends StatelessWidget {
  final String walletAddress;
  final String shortAddress;
  final String walletType;
  final String balance;

  const WalletDetailScreen({
    super.key,
    required this.walletAddress,
    required this.shortAddress,
    required this.walletType,
    required this.balance,
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
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
        title: Text(
          shortAddress,
          style: fonts.textLgSemiBold.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWalletCard(context, isLightMode),
              SizedBox(height: 16.h),
              _buildExportKeyCard(context, isLightMode),
            ],
          ),
        ),
      ),
    );
  }

  static const _palettes = [
    AvatarPalettes.purplePink,
    AvatarPalettes.yellowPurple,
    AvatarPalettes.ocean,
    AvatarPalettes.sunset,
    AvatarPalettes.forest,
    AvatarPalettes.monochrome,
  ];

  List<Color> _getPaletteForAddress(String address) {
    final random = Random(address.hashCode);
    return _palettes[random.nextInt(_palettes.length)];
  }

  Widget _buildWalletCard(
    BuildContext context,
    bool isLightMode,
  ) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                PixelatedAvatar(
                  size: 40.w,
                  gridSize: 8,
                  colorPalette: _getPaletteForAddress(walletAddress),
                  seed: walletAddress,
                  borderRadius: 8.r,
                ),
                SizedBox(width: 16.w),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: r'$0',
                        style: fonts.heading2Bold.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: '.00',
                        style: fonts.heading2Bold.copyWith(
                          color: colors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: colors.bgB2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    walletAddress,
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: walletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.l10n.addressCopiedToClipboard,
                          style: fonts.textSmRegular.copyWith(
                            color: colors.contrastWhite,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: colors.brandDefault,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    Assets.icons.copy,
                    color: colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportKeyCard(
    BuildContext context,
    bool isLightMode,
  ) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    return InkWell(
      onTap: () {
        context.router.push(
          ExportPrivateKeyRoute(walletAddress: walletAddress),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: colors.bgB1,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: colors.brandFill,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.key,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: ColorFilter.mode(
                      colors.brandDefault,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  context.l10n.exportPrivateKey,
                  style: fonts.textBaseMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colors.textTertiary,
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
