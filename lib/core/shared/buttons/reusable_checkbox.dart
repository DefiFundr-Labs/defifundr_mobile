import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/enums/checkbox_enum.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/status_checkbox_row.dart';
import 'package:flutter/material.dart';

class EnumCheckboxGroup<T> extends StatelessWidget {
  EnumCheckboxGroup({
    super.key,
    required this.options,
    this.onChanged,
  });

  final List<EnumCheckboxMeta<T>> options;
  final void Function(Map<T, bool?> selectedValues)? onChanged;

  final ValueNotifier<Map<T, bool?>> checkboxValues = ValueNotifier({});
  final ValueNotifier<bool?> allCheckboxValue = ValueNotifier(null);

  void _notifyChange() {
    if (onChanged != null) {
      onChanged!(checkboxValues.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize values if empty
    if (checkboxValues.value.isEmpty) {
      checkboxValues.value = {
        for (var opt in options) opt.value: false,
      };
    }

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
                          for (var opt in options) opt.value: newValue,
                        };
                        _notifyChange();
                      },
                      fillColor: AppColors.brandFill,
                      borderColor: AppColors.brandStroke,
                      textColor: AppColors.brandDefault,
                    );
                  },
                ),
                SizedBox(height: 24),
                ...options.map((opt) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: StatusCheckboxRow(
                      tristate: false,
                      label: opt.label,
                      value: checkboxValues.value[opt.value],
                      onChanged: (bool? newValue) {
                        checkboxValues.value = {
                          ...checkboxValues.value,
                          opt.value: newValue,
                        };

                        final allSelected =
                            checkboxValues.value.values.every((v) => v == true);
                        final anySelected =
                            checkboxValues.value.values.any((v) => v == true);
                        allCheckboxValue.value =
                            allSelected ? true : (anySelected ? null : false);

                        _notifyChange();
                      },
                      fillColor: opt.fillColor,
                      borderColor: opt.borderColor,
                      textColor: opt.textColor,
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ],
    );
  }
}
