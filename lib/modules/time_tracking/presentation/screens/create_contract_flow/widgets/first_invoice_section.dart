import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_pill_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstInvoiceSection extends StatelessWidget {
  final ContractType? contractType;
  final TextEditingController firstInvoiceDateController;
  final String firstInvoiceAmountType;
  final String paymentAmount;
  final TextEditingController customAmountController;
  final VoidCallback onSelectDate;
  final ValueChanged<String> onAmountTypeChanged;

  const FirstInvoiceSection({
    super.key,
    required this.contractType,
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
        if (contractType == ContractType.fixedRate) ...[
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
      ],
    );
  }
}
