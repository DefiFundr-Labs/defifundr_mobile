import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/status_checkbox_row.dart';
import 'package:flutter/material.dart';

class CheckBoxStatus extends StatelessWidget {
  CheckBoxStatus({
    super.key,
    this.onChanged,
  });
  final void Function(Map<QuickPaymentsStatus, bool?> selectedValues)?
      onChanged;

  final ValueNotifier<Map<QuickPaymentsStatus, bool?>> checkboxValues =
      ValueNotifier({
    QuickPaymentsStatus.processing: false,
    QuickPaymentsStatus.successful: false,
    QuickPaymentsStatus.failed: false,
  });
  final ValueNotifier<bool?> allCheckboxValue = ValueNotifier(null);

  void _notifyChange() {
    if (onChanged != null) {
      onChanged!(checkboxValues.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: checkboxValues,
          builder: (ctx, _, __) {
            return Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: allCheckboxValue,
                  builder: (ctx, ____, ___) {
                    return StatusCheckboxRow(
                      label: 'All',
                      value: allCheckboxValue.value,
                      onChanged: (value) {
                        final newValue = value ?? false;
                        allCheckboxValue.value = newValue;
                        checkboxValues.value = {
                          QuickPaymentsStatus.processing: newValue,
                          QuickPaymentsStatus.successful: newValue,
                          QuickPaymentsStatus.failed: newValue,
                        };
                        _notifyChange();
                      },
                      fillColor: context.theme.colors.brandFill,
                      borderColor: context.theme.colors.brandStroke,
                      textColor: context.theme.colors.brandDefault,
                    );
                  },
                ),
                SizedBox(height: 24),
                ...QuickPaymentsStatus.values.map((status) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: StatusCheckboxRow(
                      tristate: false,
                      label: status.titleCase,
                      value: checkboxValues.value[status],
                      onChanged: (bool? newValue) {
                        checkboxValues.value = {
                          ...checkboxValues.value,
                          status: newValue,
                        };
                        final allSelected =
                            checkboxValues.value.values.every((v) => v == true);
                        final anySelected =
                            checkboxValues.value.values.any((v) => v == true);
                        allCheckboxValue.value =
                            allSelected ? true : (anySelected ? null : false);
                        _notifyChange();
                      },
                      fillColor: status.fillColor(context),
                      borderColor: status.borderColor(context),
                      textColor: status.textColor(context),
                    ),
                  );
                }).toList()
              ],
            );
          },
        ),
      ],
    );
  }
}
