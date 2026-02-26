import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/qr_code_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class InvoiceCompleteScreen extends StatelessWidget {
  final InvoiceData invoiceData;

  const InvoiceCompleteScreen({Key? key, required this.invoiceData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 40),
                    _buildInvoiceCard(context),
                    const SizedBox(height: 40),
                    _buildActionButtons(context),
                  ],
                ),
              ),
              PrimaryButton(
                text: 'Done',
                onPressed: () => context.router.popUntilRoot(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice created & shared',
          style: context.theme.fonts.heading2Bold.copyWith(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'The invoice has been shared with your client.\nCopy the link, generate a QR code, or download\nthe file to share.',
          style: context.theme.fonts.textMdRegular.copyWith(
            fontSize: 14.sp,
            color: context.theme.colors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colors.brandDefault,
            context.theme.colors.brandHover,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 1,
            child: SvgPicture.asset(
              Assets.icons.invoiceBg,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Invoice for',
                  style: context.theme.fonts.textMdMedium.copyWith(
                    color: context.theme.colors.contrastWhite,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  '500 USDT',
                  style: context.theme.fonts.heading2SemiBold.copyWith(
                    color: context.theme.colors.contrastWhite,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '≈ \$500',
                  style: context.theme.fonts.heading2SemiBold.copyWith(
                    color: context.theme.colors.contrastWhite,
                    fontSize: 10.sp,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#INV-2025-001',
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                        color: context.theme.colors.contrastWhite,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          width: 15.w,
                          height: 15.h,
                          color: context.theme.colors.contrastWhite,
                        ),
                        SizedBox(width: 2.h),
                        Text(
                          '15 September 2025',
                          style: context.theme.fonts.textMdSemiBold.copyWith(
                            color: context.theme.colors.contrastWhite,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Assets.icons.link,
            label: 'Copy link',
            onTap: () {
              AppSnackbar.show(context, 'Link copied to clipboard');
            },
            context: context,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Assets.icons.qrCodeSvg_,
            label: 'Get QR code',
            onTap: () {
              _showQRCodeBottomSheet(context);
            },
            context: context,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Assets.icons.fileText,
            label: 'Download',
            onTap: () {
              AppSnackbar.show(context, 'Invoice downloaded');
            },
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: context.theme.colors.fillTertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 16.w,
              height: 16.h,
              fit: BoxFit.contain,
              color: context.theme.colors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: context.theme.fonts.textMdRegular.copyWith(
                fontSize: 12.sp,
                color: context.theme.colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQRCodeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const QRCodeBottomSheet(),
    );
  }
}
