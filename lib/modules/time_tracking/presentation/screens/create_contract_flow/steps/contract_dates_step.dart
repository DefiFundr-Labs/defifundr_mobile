import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractDatesStep extends StatelessWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController noticePeriodController;
  final VoidCallback onNext;

  const ContractDatesStep({
    Key? key,
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
                    suffixType: SuffixType.defaultt,
                    readOnly: true,
                    onTap: () => _selectDate(context, startDateController),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: endDateController,
                    hintText: 'End date (optional)',
                    suffixType: SuffixType.defaultt,
                    readOnly: true,
                    onTap: () => _selectDate(context, endDateController),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: noticePeriodController,
                    hintText: 'Notice period (days)',
                    keyboardType: TextInputType.number,
                  ),
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
