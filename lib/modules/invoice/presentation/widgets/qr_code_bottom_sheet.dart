import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeBottomSheet extends StatelessWidget {
  const QRCodeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildQRCode(context),
                SizedBox(height: 32.h),
                _buildActionButtons(context),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildQRCode(BuildContext context) {
    final colors = context.theme.colors;
    return QrImageView(
      data: "address",
      version: QrVersions.auto,
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
        color: colors.textPrimary,
      ),
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.circle,
        color: colors.textPrimary,
      ),
      padding: const EdgeInsets.all(0),
      gapless: false,
      embeddedImage: AssetImage(Assets.images.qrCode.path),
      size: 200.0,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Save as image',
            icon: Assets.icons.download,
            iconColor: context.theme.colors.textPrimary,
            fixedSize: Size(double.infinity, 48.h),
            onPressed: () {
              context.router.maybePop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR code saved as image')),
              );
            },
            enableShine: false,
            color: context.theme.colors.textSecondary.withAlpha(20),
            textColor: context.theme.colors.textPrimary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: 'Share QR code',
            icon: Assets.icons.share,
            iconColor: context.theme.colors.contrastWhite,
            enableShine: false,
            textColor: context.theme.colors.contrastWhite,
            fixedSize: Size(double.infinity, 48.h),
            onPressed: () {
              context.router.maybePop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR code shared')),
              );
            },
          ),
        ),
      ],
    );
  }
}
