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
import 'package:auto_route/auto_route.dart';

@RoutePage()
class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({Key? key, required this.invoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: invoice.id,
          actions: [],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (invoice.status == InvoiceStatus.overdue)
                _buildOverdueAlert(context),
              const SizedBox(height: 24),
              _buildAmountSection(context),
              const SizedBox(height: 24),
              _buildInvoiceDetailsSection(context),
              const SizedBox(height: 24),
              _buildBilledToSection(context),
              const SizedBox(height: 24),
              _buildBilledFromSection(context),
              const SizedBox(height: 24),
              _buildInvoiceBreakdownSection(context),
              const SizedBox(height: 24),
              _buildPaymentTrackerSection(context),
              const SizedBox(height: 24),
              _buildPaymentMemoSection(context),
              const SizedBox(height: 32),
              _buildActionButtons(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverdueAlert(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice Overdue',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 13.sp,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Contact your client if they\'ve initiated payment for your invoice.',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontSize: 12.sp,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.contrastWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.textSecondary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: colors.brandDefault,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt,
              color: colors.contrastWhite,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            invoice.amount,
            style: fontTheme.heading1Bold.copyWith(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '≈ \$476.19',
            style: fontTheme.textBaseRegular.copyWith(
              fontSize: 16.sp,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Invoice Details',
      isDivider: false,
      [
        _buildDetailRow(context, 'Status', '',
            statusWidget: InvoiceStatusChip(status: invoice.status)),
        _buildDetailRow(context, 'Invoice no', invoice.id),
        _buildDetailRow(context, 'Title', 'Neurolytix Initial consultation...'),
        _buildDetailRow(context, 'Network', 'Ethereum',
            hasIcon: true, iconColor: Colors.blue),
        _buildDetailRow(context, 'Asset', 'USDT',
            hasIcon: true, iconColor: Colors.green, iconText: 'T'),
        _buildDetailRow(context, 'Issue date', '15 April 2025'),
        _buildDetailRow(context, 'Due date', '29 April 2025'),
        if (invoice.status == InvoiceStatus.paid &&
            invoice.transactionId != null) ...[
          _buildDetailRow(context, 'Transaction ID', invoice.transactionId!,
              isCopyable: true),
          _buildDetailRow(context, 'Payment date', '29 April 2025'),
        ],
      ],
    );
  }

  Widget _buildBilledToSection(BuildContext context) {
    return _buildSection(context, 'Billed To', _buildContactDetails(context));
  }

  Widget _buildBilledFromSection(BuildContext context) {
    return _buildSection(context, 'Billed From', _buildContactDetails(context));
  }

  List<Widget> _buildContactDetails(BuildContext context) {
    return [
      _buildDetailRow(context, 'Name', 'Adegboyega Oluwagbemiro'),
      _buildDetailRow(context, 'Email', 'adeshinaadegboyega@icloud.com'),
      _buildDetailRow(context, 'Phone no', '+234 (801) 234 5678'),
      _buildDetailRow(context, 'Country', 'Nigeria',
          hasFlag: Assets.icons.countryFlags.nigeria),
      _buildDetailRow(context, 'Address',
          'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
    ];
  }

  Widget _buildInvoiceBreakdownSection(BuildContext context) {
    return _buildSection(
      context,
      'Invoice Breakdown',
      isDivider: false,
      [
        _buildInvoiceItem(
            context, 'Item Name', '500 USDT', '100 unit(s) at 5 USDT'),
        _buildInvoiceItem(
            context, 'Item Name', '80 USDT', '10 unit(s) at 8 USDT'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Divider(color: context.theme.colors.fillTertiary),
        ),
        _buildSummaryRow(context, 'Subtotal', '580 USDT'),
        _buildSummaryRow(context, 'VAT (20%)', '1 USDT'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Divider(color: context.theme.colors.fillTertiary),
        ),
        _buildSummaryRow(context, 'Total Amount', '581 USDT', isTotal: true),
      ],
    );
  }

  Widget _buildPaymentTrackerSection(BuildContext context) {
    return _buildSection(
      context,
      'Payment Tracker',
      isDivider: false,
      _buildPaymentTrackerItems(context),
    );
  }

  List<Widget> _buildPaymentTrackerItems(BuildContext context) {
    switch (invoice.status) {
      case InvoiceStatus.overdue:
        return [
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Invoice created and sent to client',
            subtitle: '20th April 2025, 04:40 PM',
            isCompleted: true,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.warning,
            iconColor: Colors.orange,
            title: 'Client payment overdue',
            subtitle:
                'The payment was due on 31st May 2025 but has not yet been received.',
            isCompleted: false,
          ),
        ];
      case InvoiceStatus.paid:
        return [
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Invoice created and sent to client',
            subtitle: '20th April 2025, 04:40 PM',
            isCompleted: true,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Client payment confirmed',
            subtitle: '20th April 2025, 08:40 PM',
            isCompleted: true,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Funds received in your account',
            subtitle: '20th April 2025, 08:45 PM',
            isCompleted: true,
          ),
        ];
      case InvoiceStatus.pending:
        return [
          _buildTrackerItem(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Invoice created and sent to client',
            subtitle: '20th April 2025, 04:40 PM',
            isCompleted: true,
          ),
          _buildTrackerItem(
            context,
            icon: Icons.access_time,
            iconColor: Colors.orange,
            title: 'Awaiting payment confirmation',
            subtitle:
                'Your client will get invoice access before it is due on 31st May 2025.',
            isCompleted: false,
          ),
        ];
    }
  }

  Widget _buildPaymentMemoSection(BuildContext context) {
    return _buildSection(
      context,
      'Payment Memo',
      isDivider: false,
      [
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Thank you for your business. Please remit payment according to the terms outlined in this invoice. If you have any questions regarding this invoice or the payment process, do not hesitate to contact us.',
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 13.sp,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Preview PDF',
            iconColor: context.theme.colors.textPrimary,
            color: context.theme.colors.textSecondary.withAlpha(20),
            textColor: context.theme.colors.textPrimary,
            enableShine: false,
            icon: Assets.icons.eye,
            onPressed: () {
              // Preview PDF functionality
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: 'Download PDF',
            textColor: context.theme.colors.contrastWhite,
            iconColor: context.theme.colors.contrastWhite,
            icon: Assets.icons.fileArrowDown,
            onPressed: () {
              // Download PDF functionality
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children,
      {bool? isDivider = true}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.contrastWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.textSecondary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: context.theme.fonts.heading3SemiBold.copyWith(
                fontSize: 18.sp,
                color: context.theme.colors.textPrimary,
              ),
            ),
          ),
          if (isDivider ?? true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(color: context.theme.colors.fillTertiary),
            ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Widget? statusWidget,
    bool hasIcon = false,
    Color? iconColor,
    String? iconText,
    String hasFlag = "",
    bool isCopyable = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: context.theme.fonts.textMdRegular.copyWith(
                fontSize: 13.sp,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (hasFlag.isNotEmpty) ...[
                SvgPicture.asset(
                  hasFlag,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 4.w),
              ],
              if (hasIcon) ...[
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(right: 8, top: 1),
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                  ),
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
                      : Icon(
                          Icons.currency_bitcoin,
                          color: context.theme.colors.contrastWhite,
                          size: 12,
                        ),
                ),
              ],
              if (statusWidget != null)
                statusWidget
              else
                Text(
                  value,
                  style: context.theme.fonts.textMdMedium.copyWith(
                    fontSize: 12.sp,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
              if (isCopyable)
                GestureDetector(
                  onTap: () {
                    // Copy to clipboard functionality
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(BuildContext context, String itemName, String amount,
      String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              itemName,
              style: context.theme.fonts.textMdRegular.copyWith(
                fontSize: 13.sp,
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: context.theme.fonts.textMdSemiBold.copyWith(
                  fontSize: 13.sp,
                  color: context.theme.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: context.theme.fonts.textMdRegular.copyWith(
                  fontSize: 12.sp,
                  color: context.theme.colors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String amount,
      {bool isTotal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.theme.fonts.textMdMedium.copyWith(
              fontSize: 13.sp,
              color: context.theme.colors.textPrimary,
            ),
          ),
          Text(
            amount,
            style: context.theme.fonts.textMdSemiBold.copyWith(
              fontSize: 12.sp,
              color: context.theme.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.theme.fonts.textMdMedium.copyWith(
                    fontSize: 13.sp,
                    color: isCompleted
                        ? context.theme.colors.textPrimary
                        : context.theme.colors.textSecondary,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: context.theme.fonts.textMdRegular.copyWith(
                      fontSize: 12.sp,
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
