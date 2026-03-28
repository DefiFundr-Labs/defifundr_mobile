import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/components/misc/app_sheet_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A single option in an [AppSelect] dropdown.
class AppSelectOption<T> {
  const AppSelectOption({required this.label, required this.value});

  /// Display text shown in the list and the trigger.
  final String label;

  /// The typed value returned when this option is selected.
  final T value;
}

/// A form field that opens a bottom-sheet option picker, inspired by
/// shadcn's `Select` component.
///
/// Renders as an [AppTextField]-style trigger button. Tapping it opens a
/// modal bottom sheet with a scrollable list of [AppSelectOption] items.
/// The selected label is shown in the trigger; the raw [value] is returned
/// via [onChanged].
///
/// ```dart
/// AppSelect<String>(
///   label: 'Currency',
///   placeholder: 'Select currency',
///   options: const [
///     AppSelectOption(label: 'USDC', value: 'usdc'),
///     AppSelectOption(label: 'USDT', value: 'usdt'),
///     AppSelectOption(label: 'ETH',  value: 'eth'),
///   ],
///   value: _currency,
///   onChanged: (v) => setState(() => _currency = v),
/// )
///
/// // Without label
/// AppSelect<int>(
///   placeholder: 'Select team size',
///   options: [...],
///   value: _teamSize,
///   onChanged: cubit.setTeamSize,
/// )
/// ```
class AppSelect<T> extends StatelessWidget {
  const AppSelect({
    super.key,
    required this.options,
    required this.onChanged,
    this.value,
    this.label,
    this.placeholder = 'Select an option',
    this.enabled = true,
  });

  /// The current selected value, or `null` when nothing is selected.
  final T? value;

  /// Available options.
  final List<AppSelectOption<T>> options;

  /// Called with the selected value when the user picks an option.
  final ValueChanged<T> onChanged;

  /// Optional label rendered above the trigger button.
  final String? label;

  /// Placeholder shown inside the trigger when [value] is null.
  final String placeholder;

  /// Whether the trigger is interactive. Defaults to `true`.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    final selectedLabel = options
        .where((o) => o.value == value)
        .map((o) => o.label)
        .firstOrNull;

    final hasValue = selectedLabel != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: fonts.textSmMedium.copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 6.h),
        ],
        GestureDetector(
          onTap: enabled ? () => _openSheet(context) : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: colors.bgB0,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.strokePrimary),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedLabel ?? placeholder,
                    style: fonts.textMdRegular.copyWith(
                      color: hasValue
                          ? colors.textPrimary
                          : colors.textTertiary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colors.textTertiary,
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.bgB0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppSheetHandle(),
              if (label != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      label!,
                      style: fonts.textLgBold
                          .copyWith(color: colors.textPrimary),
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: colors.strokePrimary,
                  indent: 20.w,
                  endIndent: 20.w,
                ),
                itemBuilder: (ctx, i) {
                  final opt = options[i];
                  final isSelected = opt.value == value;
                  return InkWell(
                    onTap: () {
                      Navigator.of(ctx).pop();
                      onChanged(opt.value);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              opt.label,
                              style: fonts.textBaseMedium.copyWith(
                                color: isSelected
                                    ? colors.brandDefault
                                    : colors.textPrimary,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_rounded,
                                color: colors.brandDefault, size: 18.w),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }
}
