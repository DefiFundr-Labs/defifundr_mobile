import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

@RoutePage()
class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({Key? key, required this.invoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB0,
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: invoice.id,
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (invoice.status == InvoiceStatus.overdue) ...[
                    _buildOverdueAlert(context),
                    SizedBox(height: 20.h),
                  ],
                  _buildAmountCard(context),
                  SizedBox(height: 20.h),
                  _buildInvoiceDetailsCard(context),
                  SizedBox(height: 20.h),
                  _buildBilledToCard(context),
                  SizedBox(height: 20.h),
                  _buildBilledFromCard(context),
                  SizedBox(height: 20.h),
                  _buildInvoiceBreakdownCard(context),
                  SizedBox(height: 20.h),
                  _buildPaymentTrackerCard(context),
                  SizedBox(height: 20.h),
                  _buildPaymentMemoCard(context),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildAmountCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.theme.colors.orangeDefault,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            invoice.amount,
            style: context.theme.fonts.heading1Bold.copyWith(
              fontSize: 24.sp,
              color: context.theme.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ \$476.19',
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetailsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildRow(context, 'Status',
              widget: InvoiceStatusChip(status: invoice.status)),
          const SizedBox(height: 24),
          _buildRow(context, 'Invoice no', value: invoice.id),
          const SizedBox(height: 24),
          _buildRow(context, 'Title',
              value: 'Neurolytix Initial consultation...'),
          const SizedBox(height: 24),
          _buildRow(context, 'Network',
              value: 'Ethereum', hasIcon: true, iconColor: Colors.blue),
          const SizedBox(height: 24),
          _buildRow(context, 'Asset',
              value: 'USDT',
              hasIcon: true,
              iconColor: Colors.green,
              iconText: 'T'),
          const SizedBox(height: 24),
          _buildRow(context, 'Issue date', value: '15 April 2025'),
          const SizedBox(height: 24),
          _buildRow(context, 'Due date', value: '29 April 2025'),
          if (invoice.status == InvoiceStatus.paid) ...[
            const SizedBox(height: 24),
            _buildRow(context, 'Transaction ID',
                value: invoice.transactionId ?? '0x685afa...03b3',
                isCopyable: true),
            const SizedBox(height: 24),
            _buildRow(context, 'Payment date', value: '29 April 2025'),
          ]
        ],
      ),
    );
  }

  Widget _buildBilledToCard(BuildContext context) {
    return _buildSectionCard(
      context,
      title: context.l10n.billedTo,
      children: [
        _buildRow(context, 'Name', value: 'Adegboyega Oluwagbemiro'),
        const SizedBox(height: 24),
        _buildRow(context, 'Email', value: 'adeshinaadegboyega@icloud.com'),
        const SizedBox(height: 24),
        _buildRow(context, 'Phone no', value: '+234 (801) 234 5678'),
        const SizedBox(height: 24),
        _buildRow(context, 'Country',
            value: 'Nigeria', hasFlag: Assets.icons.countryFlags.nigeria),
        const SizedBox(height: 24),
        _buildRow(context, 'Address',
            value:
                'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
      ],
    );
  }

  Widget _buildBilledFromCard(BuildContext context) {
    return _buildSectionCard(
      context,
      title: context.l10n.billedFrom,
      children: [
        _buildRow(context, 'Name', value: 'Adegboyega Oluwagbemiro'),
        const SizedBox(height: 24),
        _buildRow(context, 'Email', value: 'adeshinaadegboyega@icloud.com'),
        const SizedBox(height: 24),
        _buildRow(context, 'Phone no', value: '+234 (801) 234 5678'),
        const SizedBox(height: 24),
        _buildRow(context, 'Country',
            value: 'Nigeria', hasFlag: Assets.icons.countryFlags.nigeria),
        const SizedBox(height: 24),
        _buildRow(context, 'Address',
            value:
                'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
      ],
    );
  }

  Widget _buildInvoiceBreakdownCard(BuildContext context) {
    return _buildSectionCard(
      context,
      title: context.l10n.invoiceBreakdown,
      children: [
        _buildBreakdownItemRow(
            context, 'Item Name', '500 USDT', '100 unit(s) at 5 USDT'),
        const SizedBox(height: 24),
        _buildBreakdownItemRow(
            context, 'Item Name', '80 USDT', '10 unit(s) at 8 USDT'),
        const SizedBox(height: 24),
        _buildRow(context, 'Subtotal', value: '580 USDT'),
        const SizedBox(height: 24),
        Divider(color: context.theme.colors.fillTertiary),
        const SizedBox(height: 24),
        _buildRow(context, 'VAT (20%)', value: '1 USDT'),
        const SizedBox(height: 24),
        Divider(color: context.theme.colors.fillTertiary),
        const SizedBox(height: 24),
        _buildRow(context, 'Total Amount', value: '581 USDT', isBold: true),
      ],
    );
  }

  Widget _buildPaymentTrackerCard(BuildContext context) {
    return _buildSectionCard(
      context,
      title: context.l10n.paymentTracker,
      children: _buildPaymentTrackerItems(context),
    );
  }

  Widget _buildPaymentMemoCard(BuildContext context) {
    return _buildSectionCard(
      context,
      title: context.l10n.paymentMemo,
      children: [
        Text(
          context.l10n.invoiceThankYouNote,
          style: context.theme.fonts.textMdRegular.copyWith(
            color: context.theme.colors.textPrimary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.theme.fonts.heading3SemiBold.copyWith(
              fontSize: 16.sp,
              color: context.theme.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label, {
    String? value,
    Widget? widget,
    bool isBold = false,
    bool hasIcon = false,
    Color? iconColor,
    String? iconText,
    String hasFlag = "",
    bool isCopyable = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: isBold
                  ? context.theme.colors.textPrimary
                  : context.theme.colors.textSecondary,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasFlag.isNotEmpty) ...[
                SvgPicture.asset(
                  hasFlag,
                  width: 20,
                  height: 14,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 8.w),
              ],
              if (hasIcon) ...[
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(right: 8, top: 1),
                  decoration:
                      BoxDecoration(color: iconColor, shape: BoxShape.circle),
                  child: iconText != null
                      ? Center(
                          child: Text(
                            iconText,
                            style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.contrastWhite,
                              fontSize: 10.sp,
                            ),
                          ),
                        )
                      : Icon(Icons.currency_bitcoin,
                          color: context.theme.colors.contrastWhite, size: 12),
                ),
              ],
              if (widget != null)
                widget
              else if (value != null)
                Flexible(
                  child: Text(
                    value,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              if (isCopyable) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.copy,
                      size: 16, color: context.theme.colors.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownItemRow(
      BuildContext context, String title, String amount, String rate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: context.theme.fonts.textMdMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 2),
              Text(
                rate,
                style: context.theme.fonts.textSmRegular.copyWith(
                  color: context.theme.colors.textSecondary,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverdueAlert(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.theme.colors.redFill,
        border: Border.all(color: context.theme.colors.redDefault),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.invoiceOverdue,
            style: context.theme.fonts.textMdSemiBold.copyWith(
              color: context.theme.colors.redDefault,
            ),
          ),
          Text(
            'Check with your client if they\'ve initiated payment for your invoice.',
            style: context.theme.fonts.textSmRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentTrackerItems(BuildContext context) {
    switch (invoice.status) {
      case InvoiceStatus.overdue:
      case InvoiceStatus.pending:
        return [
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: context.theme.colors.greenDefault,
            title: context.l10n.invoiceCreatedSentClient,
            subtitle: '20th April 2025, 04:40 PM',
            isCompleted: true,
            lineColor: context.theme.colors.greenDefault,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.watch_later_outlined,
            iconColor: invoice.status == InvoiceStatus.overdue
                ? context.theme.colors.redDefault
                : context.theme.colors.orangeDefault,
            title: invoice.status == InvoiceStatus.overdue
                ? 'Client payment overdue'
                : 'Awaiting payment confirmation',
            subtitle: invoice.status == InvoiceStatus.overdue
                ? 'The payment was expected by 31st May 2025 but has not yet been received.'
                : 'Your client will get invoice access before it is due on 31st May 2025.',
            isCompleted: false,
          ),
          _buildTrackerItem(
            context,
            customIcon: DashedCircleIcon(
                color:
                    context.theme.colors.textSecondary.withValues(alpha: 0.5)),
            title: context.l10n.processClientPayment,
            isCompleted: false,
            isGreyedOut: true,
          ),
          _buildTrackerItem(
            context,
            customIcon: DashedCircleIcon(
                color:
                    context.theme.colors.textSecondary.withValues(alpha: 0.5)),
            subtitle:
                context.l10n.fundsReflectedMessage,
            isCompleted: false,
            isGreyedOut: true,
            isLast: true,
          ),
        ];

      case InvoiceStatus.paid:
        return [
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: context.theme.colors.greenDefault,
            title: context.l10n.invoiceCreatedSentClient,
            subtitle: '20th April 2025, 04:40 PM',
            isCompleted: true,
            lineColor: context.theme.colors.greenDefault,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: context.theme.colors.greenDefault,
            title: context.l10n.clientPaymentConfirmed,
            subtitle: '20th April 2025, 08:40 PM',
            isCompleted: true,
            lineColor: context.theme.colors.greenDefault,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: context.theme.colors.greenDefault,
            title: context.l10n.clientPaymentProcessed,
            subtitle: '20th April 2025, 08:45 PM',
            isCompleted: true,
            lineColor: context.theme.colors.greenDefault,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: context.theme.colors.greenDefault,
            title: context.l10n.fundsReceivedInAccount,
            subtitle: '20th April 2025, 08:45 PM',
            isCompleted: true,
            isLast: true,
          ),
        ];
    }
  }

  Widget _buildTrackerItem(
    BuildContext context, {
    Widget? customIcon,
    IconData? icon,
    Color? iconColor,
    String? title,
    String? subtitle,
    required bool isCompleted,
    bool isLast = false,
    Color? lineColor,
    bool isGreyedOut = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              customIcon ??
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                  ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: lineColor ??
                        context.theme.colors.strokeSecondary
                            .withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null && title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      title,
                      style: context.theme.fonts.textMdMedium.copyWith(
                        color: isGreyedOut
                            ? context.theme.colors.textSecondary
                                .withValues(alpha: 0.5)
                            : context.theme.colors.textPrimary,
                      ),
                    ),
                  ),
                if (subtitle != null && subtitle.isNotEmpty) ...[
                  if (title != null && title.isNotEmpty)
                    const SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(
                        top: (title == null || title.isEmpty) ? 2.0 : 0.0),
                    child: Text(
                      subtitle,
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: isGreyedOut
                            ? context.theme.colors.textSecondary
                                .withValues(alpha: 0.5)
                            : context.theme.colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 40.h),
      color: context.theme.colors.bgB1,
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              text: context.l10n.previewPdf,
              iconColor: context.theme.colors.textPrimary,
              color: context.theme.colors.fillTertiary,
              textColor: context.theme.colors.textPrimary,
              enableShine: false,
              icon: Assets.icons.eye,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrimaryButton(
              text: context.l10n.downloadPdf,
              textColor: context.theme.colors.textPrimary,
              iconColor: context.theme.colors.textPrimary,
              icon: Assets.icons.fileArrowDown,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class DashedCircleIcon extends StatelessWidget {
  final Color color;
  const DashedCircleIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CustomPaint(painter: DashedCirclePainter(color: color)),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    const int dashCount = 8;
    const double dashLength = (2 * 3.141592653589793) / (dashCount * 2);
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(rect, i * 2 * dashLength, dashLength, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
