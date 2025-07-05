import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssetDepositScreen extends StatelessWidget {
  final NetworkAsset asset;
  final Network network;
  final String address;

  const AssetDepositScreen({
    super.key,
    required this.asset,
    required this.network,
    required this.address,
  });

  // Constants
  static const double _qrCodeSize = 200.0;
  static const double _iconSize = 20.0;
  static const double _containerPadding = 20.0;
  static const double _buttonBorderRadius = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          centerTitle: false,
          isBack: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(_containerPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWarningBanner(context),
              SizedBox(height: 20.h),
              _buildDepositDetails(context),
              const Spacer(),
              _buildShareButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningBanner(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.icons.warning, width: 24, height: 24),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    fontTheme.textMdMedium.copyWith(color: colors.textPrimary),
                children: [
                  const TextSpan(text: 'Send only '),
                  TextSpan(
                    text: asset.name,
                    style: fontTheme.textMdMedium.copyWith(
                      color: colors.brandActive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' via the ',
                  ),
                  TextSpan(
                    text: network.name,
                    style: fontTheme.textMdMedium.copyWith(
                      color: colors.brandActive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' network. Using any other asset or network will result in permanent loss.',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDepositDetails(
    BuildContext context,
  ) {
    final colors = context.theme.colors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _containerPadding,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          _buildQRCode(context),
          SizedBox(height: 32.h),
          _buildDetailsSection(context),
        ],
      ),
    );
  }

  Widget _buildQRCode(BuildContext context) {
    final colors = context.theme.colors;
    return QrImageView(
      data: address,
      version: QrVersions.auto,
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
        color: colors.textPrimary,
      ),
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.circle,
        color: colors.brandActive,
      ),
      padding: const EdgeInsets.all(0),
      gapless: false,
      embeddedImage: AssetImage(Assets.images.qrIcon.path),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: const Size(40, 40),
        color: colors.textPrimary,
      ),
      size: _qrCodeSize,
      backgroundColor: colors.bgB0,
      foregroundColor: colors.textPrimary,
    );
  }

  Widget _buildDetailsSection(
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildDetailRow(
          label: 'Network',
          icon: network.iconPath,
          value: network.name,
          context: context,
        ),
        SizedBox(height: 32.h),
        _buildDetailRow(
          label: 'Asset',
          icon: asset.iconPath,
          value: asset.name,
          context: context,
        ),
        SizedBox(height: 32.h),
        _buildAddressRow(context),
      ],
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String icon,
    required String value,
    required BuildContext context,
  }) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: fontTheme.textMdRegular.copyWith(
            color: colors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        Row(
          children: [
            Image.asset(icon, width: _iconSize, height: _iconSize),
            const SizedBox(width: 4),
            Text(value,
                style: fontTheme.textMdMedium.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressRow(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: fontTheme.textMdRegular.copyWith(
            color: colors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                address,
                style: fontTheme.textMdMedium.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => _copyToClipboard(),
              child: SvgPicture.asset(
                Assets.icons.copy,
                color: colors.contrastBlack,
                height: _iconSize,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShareButton(
    BuildContext context,
  ) {
    final colors = context.theme.colors;

    return SecondaryButton(
      text: 'Share address',
      icon: Assets.icons.signOut,
      enableShake: true,
      textColor: colors.textWhite,
      backgroundColor: colors.brandDefault,
      textSize: 14.sp,
      onPressed: () {
        _shareAddress();
      },
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: address));
    // TODO: Show snackbar or toast confirmation
  }

  void _shareAddress() {
    // TODO: Implement share functionality using share_plus package
    // Share.share('My crypto address: $address');
  }
}
