import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_pill_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceDetailsSection extends StatelessWidget {
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

  const InvoiceDetailsSection({
    super.key,
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
