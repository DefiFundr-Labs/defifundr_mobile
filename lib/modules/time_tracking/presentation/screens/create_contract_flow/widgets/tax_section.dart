import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaxSection extends StatelessWidget {
  final bool addInclusiveTax;
  final String? taxType;
  final TextEditingController taxIdController;
  final TextEditingController taxRateController;
  final ValueChanged<bool> onTaxChanged;
  final VoidCallback onSelectTaxType;

  const TaxSection({
    super.key,
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
