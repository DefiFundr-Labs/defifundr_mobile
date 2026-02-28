import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class SetupInstructionsScreen extends StatefulWidget {
  const SetupInstructionsScreen({super.key});

  @override
  State<SetupInstructionsScreen> createState() =>
      _SetupInstructionsScreenState();
}

class _SetupInstructionsScreenState extends State<SetupInstructionsScreen> {
  static const String _setupKey = 'XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX';
  static const String _qrData =
      'otpauth://totp/DeFiFundr?secret=IMMIUP7L6OB5VQHXIR5EATEI7CISHGGG&issuer=DeFiFundr';

  bool _showToast = false;

  void _copySetupKey() {
    Clipboard.setData(const ClipboardData(text: _setupKey));
    setState(() => _showToast = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showToast = false);
    });
  }

  void _showQrCode() {
    final colors = context.theme.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: colors.bgB1,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grayTertiary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            QrImageView(
              data: _qrData,
              version: QrVersions.auto,
              size: 200.w,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 24.h),
            Text(
              context.l10n.scanQrCodeTitle,
              style: context.theme.textTheme.headlineLarge?.copyWith(
                fontSize: 20.sp,
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                context.l10n.scanQrCodeDesc,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PrimaryButton(
                text: context.l10n.close,
                isEnabled: true,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
                height:
                    MediaQuery.systemGestureInsetsOf(context).bottom + 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text(
                          context.l10n.setupInstructions,
                          style:
                              context.theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 24.sp,
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildInstructionsCard(context),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                  child: PrimaryButton(
                    text: context.l10n.continueText,
                    isEnabled: true,
                    onPressed: () =>
                        context.router.push(const MoreTwoFaAuthCodeRoute()),
                  ),
                ),
                SizedBox(
                    height:
                        MediaQuery.systemGestureInsetsOf(context).bottom + 8),
              ],
            ),
          ),
          // Toast overlay
          if (_showToast)
            Positioned(
              bottom: 80.h,
              left: 20.w,
              right: 20.w,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: colors.textPrimary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    context.l10n.setupKeyCopied,
                    style: fonts.textBaseMedium.copyWith(
                      color: colors.contrastWhite,
                    ),
                  ),
                ),
              ),
            ),
        ],
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

  Widget _buildInstructionsCard(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        color: isLight ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.strokeSecondary),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStep(
            context,
            number: 1,
            title: context.l10n.step1Title,
            description:
                context.l10n.step1Desc,
            isLast: false,
          ),
          _buildStep(
            context,
            number: 2,
            title: context.l10n.step2Title,
            description:
                context.l10n.step2Desc,
            isLast: false,
          ),
          // Setup key display
          Padding(
            padding: EdgeInsets.only(left: 36.w, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _setupKey,
                  style: fonts.heading2Bold.copyWith(
                    color: colors.textPrimary,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _copySetupKey,
                      child: Text(
                        context.l10n.copySetupKey,
                        style: fonts.textBaseMedium.copyWith(
                          color: colors.brandDefault,
                        ),
                      ),
                    ),
                    Text(
                      '  •  ',
                      style: fonts.textBaseMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: _showQrCode,
                      child: Text(
                        context.l10n.viewBarcodeQrCode,
                        style: fonts.textBaseMedium.copyWith(
                          color: colors.brandDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildStep(
            context,
            number: 3,
            title: context.l10n.step3Title,
            description:
                context.l10n.step3Desc,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required int number,
    required String title,
    required String description,
    required bool isLast,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: colors.brandDefault,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: fonts.textSmBold.copyWith(
                      color: colors.contrastWhite,
                    ),
                  ),
                ),
              ),
              if (!isLast) ...[
                SizedBox(height: 4.h),
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: colors.brandDefault,
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: fonts.textBaseMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }
}
