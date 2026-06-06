import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/first_invoice_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/invoice_details_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/payment_details_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/tax_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PaymentInvoiceStep extends StatelessWidget {
  final ContractType? contractType;
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final String? rateUnit;
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
  final ValueChanged<String> onRateUnitChanged;
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
    this.contractType,
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.rateUnit,
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
    required this.onRateUnitChanged,
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
                PaymentDetailsSection(
                  contractType: contractType,
                  selectedNetwork: selectedNetwork,
                  selectedAsset: selectedAsset,
                  rateUnit: rateUnit,
                  paymentAmountController: paymentAmountController,
                  onSelectNetwork: () => _showNetworkPicker(context),
                  onSelectAsset: () => _showAssetPicker(context),
                  onSelectRateUnit: () => _showRateUnitPicker(context),
                ),
                SizedBox(height: 20.h),
                InvoiceDetailsSection(
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
                FirstInvoiceSection(
                  contractType: contractType,
                  firstInvoiceDateController: firstInvoiceDateController,
                  firstInvoiceAmountType: firstInvoiceAmountType,
                  paymentAmount: paymentAmountController.text,
                  customAmountController: firstInvoiceCustomAmountController,
                  onSelectDate: () =>
                      _selectDate(context, firstInvoiceDateController),
                  onAmountTypeChanged: onFirstInvoiceTypeChanged,
                ),
                SizedBox(height: 24.h),
                TaxSection(
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

  void _showRateUnitPicker(BuildContext context) {
    _showPickerBottomSheet(
      context: context,
      title: 'Rate unit',
      items: const ['Per Hour', 'Per Day', 'Per Week', 'Per Deliverable'],
      onSelected: (val) => onRateUnitChanged(val as String),
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
