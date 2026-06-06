import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_pill_bar.dart';

class PaymentInvoiceStep extends StatelessWidget {
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final String? invoiceFrequency;
  final String? issueInvoiceOn;
  final String? issueSecondInvoiceOn;
  final String monthlyInvoiceMode;
  final String? paymentDue;
  final String firstInvoiceAmountType;
  final bool addInclusiveTax;
  final String? taxType;
  final TextEditingController paymentAmountController;
  final TextEditingController firstInvoiceDateController;
  final TextEditingController firstInvoiceCustomAmountController;
  final TextEditingController taxIdController;
  final TextEditingController taxRateController;
  final ValueChanged<Network?> onNetworkChanged;
  final ValueChanged<NetworkAsset?> onAssetChanged;
  final ValueChanged<String> onFrequencyChanged;
  final ValueChanged<String> onIssueOnChanged;
  final ValueChanged<String> onIssueSecondOnChanged;
  final ValueChanged<String> onMonthlyModeChanged;
  final ValueChanged<String> onPaymentDueChanged;
  final ValueChanged<String> onFirstInvoiceTypeChanged;
  final ValueChanged<bool> onTaxChanged;
  final ValueChanged<String> onTaxTypeChanged;
  final VoidCallback onNext;

  const PaymentInvoiceStep({
    Key? key,
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.invoiceFrequency,
    required this.issueInvoiceOn,
    required this.issueSecondInvoiceOn,
    required this.monthlyInvoiceMode,
    required this.paymentDue,
    required this.firstInvoiceAmountType,
    required this.addInclusiveTax,
    required this.taxType,
    required this.paymentAmountController,
    required this.firstInvoiceDateController,
    required this.firstInvoiceCustomAmountController,
    required this.taxIdController,
    required this.taxRateController,
    required this.onNetworkChanged,
    required this.onAssetChanged,
    required this.onFrequencyChanged,
    required this.onIssueOnChanged,
    required this.onIssueSecondOnChanged,
    required this.onMonthlyModeChanged,
    required this.onPaymentDueChanged,
    required this.onFirstInvoiceTypeChanged,
    required this.onTaxChanged,
    required this.onTaxTypeChanged,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PaymentDetailsSection(
                  selectedNetwork: selectedNetwork,
                  selectedAsset: selectedAsset,
                  paymentAmountController: paymentAmountController,
                  onSelectNetwork: () => _showNetworkPicker(context),
                  onSelectAsset: () => _showAssetPicker(context),
                ),
                SizedBox(height: 20.h),
                _InvoiceDetailsSection(
                  invoiceFrequency: invoiceFrequency,
                  issueInvoiceOn: issueInvoiceOn,
                  issueSecondInvoiceOn: issueSecondInvoiceOn,
                  monthlyInvoiceMode: monthlyInvoiceMode,
                  paymentDue: paymentDue,
                  onSelectFrequency: () => _showFrequencyPicker(context),
                  onSelectIssueOn: () => _showIssueOnPicker(context),
                  onSelectIssueSecondOn: () =>
                      _showIssueSecondOnPicker(context),
                  onMonthlyModeChanged: onMonthlyModeChanged,
                  onSelectPaymentDue: () => _showPaymentDuePicker(context),
                ),
                SizedBox(height: 20.h),
                _FirstInvoiceSection(
                  firstInvoiceDateController: firstInvoiceDateController,
                  firstInvoiceAmountType: firstInvoiceAmountType,
                  paymentAmount: paymentAmountController.text,
                  customAmountController: firstInvoiceCustomAmountController,
                  onSelectDate: () =>
                      _selectDate(context, firstInvoiceDateController),
                  onAmountTypeChanged: onFirstInvoiceTypeChanged,
                ),
                SizedBox(height: 24.h),
                _TaxSection(
                  addInclusiveTax: addInclusiveTax,
                  taxType: taxType,
                  taxIdController: taxIdController,
                  taxRateController: taxRateController,
                  onTaxChanged: onTaxChanged,
                  onSelectTaxType: () => _showTaxTypePicker(context),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
          child: PrimaryButton(
            text: 'Continue',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }

  // --- Picker Dialogs ---

  void _showNetworkPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Select network',
      items: Network.supportedNetworks,
      onSelected: (val) => onNetworkChanged(val as Network),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as Network).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
        ],
      ),
    );
  }

  void _showAssetPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Select assets',
      items: NetworkAsset.supportedAssets,
      onSelected: (val) => onAssetChanged(val as NetworkAsset),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as NetworkAsset).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
          const Spacer(),
          Text(item.balance, style: context.theme.fonts.textMdRegular),
        ],
      ),
    );
  }

  void _showFrequencyPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Invoice frequency',
      items: const ['Weekly', 'Bi-weekly', 'Semi-monthly', 'Monthly'],
      onSelected: (val) => onFrequencyChanged(val as String),
    );
  }

  void _showIssueOnPicker(BuildContext context) {
    List<String> items = [];
    if (invoiceFrequency == 'Weekly') {
      items = const [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
    } else if (invoiceFrequency == 'Bi-weekly') {
      items = const [
        'Every other Monday',
        'Every other Tuesday',
        'Every other Wednesday',
        'Every other Thursday',
        'Every other Friday',
        'Every other Saturday',
        'Every other Sunday'
      ];
    } else if (invoiceFrequency == 'Semi-monthly') {
      items = const [
        '15th of the month',
        '1st of the month',
        'Last day of the month'
      ];
    } else if (invoiceFrequency == 'Monthly') {
      if (monthlyInvoiceMode == 'Ends on date') {
        items = const [
          '15th of the month',
          '1st of the month',
          'Last day of the month'
        ];
      } else {
        items = const [
          'Last Monday of the month',
          'First Friday of the month',
          'Last day of the month'
        ];
      }
    } else {
      items = const [
        'Every Monday',
        'Every Tuesday',
        'Every Wednesday',
        'Every Thursday',
        'Every Friday',
        'Last day of the month'
      ];
    }

    _showPickerBottomSheet(
      context: context,
      title: 'Issue Invoice On',
      items: items,
      onSelected: (val) => onIssueOnChanged(val as String),
    );
  }

  void _showIssueSecondOnPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Issue Second Invoice On',
      items: const [
        'Last day of the month',
        '15th of the month',
        '1st of the month'
      ],
      onSelected: (val) => onIssueSecondOnChanged(val as String),
    );
  }

  void _showPaymentDuePicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Payment due',
      items: const [
        'Same day',
        '7 days later',
        '14 days later',
        '30 days later'
      ],
      onSelected: (val) => onPaymentDueChanged(val as String),
    );
  }

  void _showTaxTypePicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Select tax type',
      items: const ['VAT', 'GST', 'Sales Tax'],
      onSelected: (val) => onTaxTypeChanged(val as String),
    );
  }

  void _showPickerBottomSheet({
    required BuildContext context,
    required String title,
    required List<dynamic> items,
    required ValueChanged<dynamic> onSelected,
    Widget Function(dynamic)? itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet(
        title: title,
        items: items,
        onSelected: (val) {
          onSelected(val);
          context.router.maybePop();
        },
        itemBuilder: itemBuilder,
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }
}

// --- Sub-widgets for sections ---

class _PaymentDetailsSection extends StatelessWidget {
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final TextEditingController paymentAmountController;
  final VoidCallback onSelectNetwork;
  final VoidCallback onSelectAsset;

  const _PaymentDetailsSection({
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.paymentAmountController,
    required this.onSelectNetwork,
    required this.onSelectAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment details', style: context.theme.fonts.textBaseMedium),
        SizedBox(height: 20.h),
        AppTextField(
          controller: TextEditingController(text: selectedNetwork?.name ?? ''),
          labelText: 'Network',
          hintText: 'Select network',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectNetwork,
          prefixType: selectedNetwork != null
              ? PrefixType.customWidget
              : PrefixType.none,
          prefixWidget: selectedNetwork != null
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(selectedNetwork!.iconPath,
                      width: 24, height: 24),
                )
              : null,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: paymentAmountController,
          hintText: 'Amount',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
          contentPadding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          prefixType: PrefixType.customWidget,
          prefixWidget: GestureDetector(
            onTap: onSelectAsset,
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedAsset != null)
                    Image.asset(selectedAsset!.iconPath, width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(selectedAsset?.name ?? 'USDT',
                      style: context.theme.fonts.textMdMedium),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 24,
                    color: context.theme.colors.strokeSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InvoiceDetailsSection extends StatelessWidget {
  final String? invoiceFrequency;
  final String? issueInvoiceOn;
  final String? issueSecondInvoiceOn;
  final String monthlyInvoiceMode;
  final String? paymentDue;
  final VoidCallback onSelectFrequency;
  final VoidCallback onSelectIssueOn;
  final VoidCallback onSelectIssueSecondOn;
  final ValueChanged<String> onMonthlyModeChanged;
  final VoidCallback onSelectPaymentDue;

  const _InvoiceDetailsSection({
    required this.invoiceFrequency,
    required this.issueInvoiceOn,
    required this.issueSecondInvoiceOn,
    required this.monthlyInvoiceMode,
    required this.paymentDue,
    required this.onSelectFrequency,
    required this.onSelectIssueOn,
    required this.onSelectIssueSecondOn,
    required this.onMonthlyModeChanged,
    required this.onSelectPaymentDue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Invoice details', style: context.theme.fonts.textBaseMedium),
        SizedBox(height: 20.h),
        AppTextField(
          controller: TextEditingController(text: invoiceFrequency ?? ''),
          labelText: 'Invoice frequency',
          hintText: 'Invoice frequency',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectFrequency,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: TextEditingController(text: issueInvoiceOn ?? ''),
          labelText: invoiceFrequency == 'Semi-monthly'
              ? 'Issue First Invoice On'
              : 'Issue Invoice On',
          hintText: 'Select date',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectIssueOn,
        ),
        if (invoiceFrequency == 'Semi-monthly') ...[
          SizedBox(height: 20.h),
          AppTextField(
            controller: TextEditingController(text: issueSecondInvoiceOn ?? ''),
            labelText: 'Issue Second Invoice On',
            hintText: 'Select date',
            suffixType: SuffixType.defaultt,
            readOnly: true,
            onTap: onSelectIssueSecondOn,
          ),
        ],
        if (invoiceFrequency == 'Monthly') ...[
          SizedBox(height: 20.h),
          SelectionPillBar(
            options: const ['Ends on date', 'Ends on weekday'],
            selectedOption: monthlyInvoiceMode,
            onChanged: onMonthlyModeChanged,
          ),
          if (monthlyInvoiceMode == 'Ends on date' &&
              issueInvoiceOn == '15th of the month') ...[
            SizedBox(height: 12.h),
            Text(
              'Invoice cycle runs 16th - 15th of the following month',
              style: context.theme.fonts.textXsRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ],
        ],
        SizedBox(height: 20.h),
        AppTextField(
          controller: TextEditingController(text: paymentDue ?? ''),
          labelText: 'Payment due',
          hintText: 'Payment due',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectPaymentDue,
        ),
      ],
    );
  }
}

class _FirstInvoiceSection extends StatelessWidget {
  final TextEditingController firstInvoiceDateController;
  final String firstInvoiceAmountType;
  final String paymentAmount;
  final TextEditingController customAmountController;
  final VoidCallback onSelectDate;
  final ValueChanged<String> onAmountTypeChanged;

  const _FirstInvoiceSection({
    required this.firstInvoiceDateController,
    required this.firstInvoiceAmountType,
    required this.paymentAmount,
    required this.customAmountController,
    required this.onSelectDate,
    required this.onAmountTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('First invoice', style: context.theme.fonts.textBaseMedium),
        SizedBox(height: 20.h),
        AppTextField(
          controller: firstInvoiceDateController,
          labelText: 'Date',
          hintText: 'Select date',
          suffixType: SuffixType.customWidget,
          suffixWidget: const Icon(Icons.calendar_today_outlined,
              size: 20, color: AppColors.grayTertiary),
          readOnly: true,
          onTap: onSelectDate,
        ),
        SizedBox(height: 16.h),
        SelectionPillBar(
          options: const ['Full amount', 'Custom amount'],
          selectedOption: firstInvoiceAmountType,
          onChanged: onAmountTypeChanged,
          borderRadius: 12,
          padding: 4,
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly rate',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  )),
              Text(paymentAmount.isEmpty ? '--' : paymentAmount,
                  style: context.theme.fonts.textMdBold),
            ],
          ),
        ),
        if (firstInvoiceAmountType == 'Custom amount') ...[
          SizedBox(height: 8.h),
          AppTextField(
            controller: customAmountController,
            hintText: 'Amount',
            keyboardType: TextInputType.number,
          ),
        ],
        SizedBox(height: 8.h),
        Text(
          firstInvoiceAmountType == 'Full amount'
              ? 'You would receive the full monthly amount for your first payment.'
              : 'You would receive the set amount for your first payment.',
          style: context.theme.fonts.textXsRegular.copyWith(
            color: context.theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TaxSection extends StatelessWidget {
  final bool addInclusiveTax;
  final String? taxType;
  final TextEditingController taxIdController;
  final TextEditingController taxRateController;
  final ValueChanged<bool> onTaxChanged;
  final VoidCallback onSelectTaxType;

  const _TaxSection({
    required this.addInclusiveTax,
    required this.taxType,
    required this.taxIdController,
    required this.taxRateController,
    required this.onTaxChanged,
    required this.onSelectTaxType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Add inclusive tax',
                    style: context.theme.fonts.textMdRegular),
              ),
              Switch(
                value: addInclusiveTax,
                onChanged: onTaxChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: context.theme.colors.brandDefault,
              ),
            ],
          ),
        ),
        if (addInclusiveTax) ...[
          SizedBox(height: 20.h),
          AppTextField(
            controller: TextEditingController(text: taxType ?? ''),
            labelText: 'Tax type',
            hintText: 'Select tax type',
            suffixType: SuffixType.defaultt,
            readOnly: true,
            onTap: onSelectTaxType,
          ),
          SizedBox(height: 8.h),
          Text(
            'e.g VAT, GST, HST, PST',
            style: context.theme.fonts.textXsRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: taxIdController,
            hintText: 'ID / account number',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: taxRateController,
            hintText: 'Tax rate',
            keyboardType: TextInputType.number,
            suffixType: SuffixType.customWidget,
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '%',
                style: context.theme.fonts.textMdRegular.copyWith(
                  color: context.theme.colors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
