import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';

class ContractDatesStep extends StatelessWidget {
  final ContractType? contractType;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController noticePeriodController;
  final VoidCallback onNext;

  const ContractDatesStep({
    Key? key,
    this.contractType,
    required this.startDateController,
    required this.endDateController,
    required this.noticePeriodController,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: startDateController,
                    hintText: 'Start date',
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Icon(Icons.calendar_today_outlined,
                        color: context.theme.colors.grayTertiary),
                    readOnly: true,
                    onTap: () => _selectDate(context, startDateController),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: endDateController,
                    hintText: 'End date (optional)',
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Icon(Icons.calendar_today_outlined,
                        color: context.theme.colors.grayTertiary),
                    readOnly: true,
                    onTap: () => _selectDate(context, endDateController),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: noticePeriodController,
                    hintText: 'Termination notice period',
                    suffixType: SuffixType.customWidget,
                    suffixWidget: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        'days',
                        style: context.theme.fonts.textMdRegular.copyWith(
                          color: context.theme.colors.textSecondary,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  if (contractType == ContractType.payAsYouGo ||
                      contractType == ContractType.milestone) ...[
                    SizedBox(height: 12.h),
                    Text(
                      'Either party may terminate this contract by the specified notice, after which the contract will end.',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          PrimaryButton(
            text: 'Continue',
            onPressed: onNext,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
