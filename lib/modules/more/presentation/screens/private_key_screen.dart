// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class PrivateKeyScreen extends StatelessWidget {
  final String walletAddress;
  final String privateKey;

  const PrivateKeyScreen({
    super.key,
    required this.walletAddress,
    required this.privateKey,
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
          'Your private key',
          style: fonts.textLgSemiBold.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    _buildWarningBanner(context, colors, fonts),
                    SizedBox(height: 20.h),
                    _buildKeyContainer(context, colors, fonts, isLightMode),
                    SizedBox(height: 16.h),
                    _buildCopyButton(context, colors, fonts),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: 'Done',
                onPressed: () => context.router.maybePop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningBanner(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.redDefault.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.redDefault.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🔒', style: TextStyle(fontSize: 18.sp)),
              SizedBox(width: 8.w),
              Text(
                'Do Not Share Your Private Key',
                style: fonts.textBaseSemiBold.copyWith(
                  color: colors.redDefault,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Your private key gives full access to your wallet. Never share it with anyone. If someone else gets it, they can steal your assets.',
            textAlign: TextAlign.center,
            style: fonts.textSmRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyContainer(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
    bool isLightMode,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SelectableText(
        privateKey,
        style: fonts.textBaseMedium.copyWith(
          color: colors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildCopyButton(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
  ) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: privateKey));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Private key copied to clipboard',
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.copy_rounded,
            color: colors.textTertiary,
            size: 18.w,
          ),
          SizedBox(width: 6.w),
          Text(
            'Copy to clipboard',
            style: fonts.textSmMedium.copyWith(
              color: colors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
