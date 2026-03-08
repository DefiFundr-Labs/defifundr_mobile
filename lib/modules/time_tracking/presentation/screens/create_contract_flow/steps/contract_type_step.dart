import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/components/radio_selection_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractTypeStep extends StatelessWidget {
  final ContractType? selectedType;
  final ValueChanged<ContractType> onTypeChanged;
  final VoidCallback onNext;

  const ContractTypeStep({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
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
                  Text(
                    'Choose contract type',
                    style: context.theme.fonts.textBaseSemiBold,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Choose what type of contract you want to create for this client',
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ...ContractType.values.map((type) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: RadioSelectionCard(
                          title: type.title,
                          subtitle: type.description,
                          isSelected: selectedType == type,
                          onTap: () => onTypeChanged(type),
                        ),
                      )),
                ],
              ),
            ),
          ),
          PrimaryButton(
            text: 'Continue',
            onPressed: selectedType != null ? onNext : null,
          ),
        ],
      ),
    );
  }
}
