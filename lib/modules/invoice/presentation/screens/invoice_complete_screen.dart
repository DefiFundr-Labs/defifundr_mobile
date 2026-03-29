import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/qr_code_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class InvoiceCompleteScreen extends StatelessWidget {
  final InvoiceData invoiceData;

  const InvoiceCompleteScreen({Key? key, required this.invoiceData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeFiRaiseAppBar(
        title: '',
        isBack: true,
        actions: const [],
        onBack: () => context.router.maybePop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Invoice created & shared',
                              style: context.theme.fonts.heading2Bold),
                          const SizedBox(height: 4),
                          Text(
                            textAlign: TextAlign.justify,
                            'The invoice has been shared with your client. Copy the link, generate a QR code, or download the file to share.',
                            style: context.theme.fonts.textMdRegular.copyWith(
                              color: context.theme.colors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      _buildInvoiceCard(context),
                      SizedBox(height: 24.h),
                      _buildActionButtons(context),
                    ],
                  ),
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

  Widget _buildInvoiceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.colors.brandDefault,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: SvgPicture.asset(
              Assets.icons.invoiceBg,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Invoice for',
                      style: context.theme.fonts.textSmMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '500 USDT',
                      style: context.theme.fonts.heading2SemiBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '≈ \$500',
                      style: context.theme.fonts.textXsMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#INV-2025-001',
                      style: context.theme.fonts.textSmSemiBold
                          .copyWith(color: Colors.white),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          width: 14.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '15 September 2025',
                          style: context.theme.fonts.textSmSemiBold.copyWith(
                            color: Colors.white,
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
        SizedBox(width: 8.w),
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
        SizedBox(width: 8.w),
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
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: context.theme.colors.fillTertiary,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: context.theme.colors.strokeSecondary,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
              color: context.theme.colors.graySecondary,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: context.theme.fonts.textMdMedium.copyWith(
                  color: context.theme.colors.textSecondary, fontSize: 13.sp),
              textAlign: TextAlign.center,
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
