import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/components/misc/app_sheet_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// A form field that opens a bottom-sheet calendar date picker, inspired by
/// shadcn's `DatePicker` component.
///
/// Renders as an [AppTextField]-style trigger. Tapping opens a modal bottom
/// sheet with Flutter's [CalendarDatePicker], styled with brand colors.
///
/// ```dart
/// AppDatePicker(
///   label: 'Date of Birth',
///   value: _dob,
///   onChanged: (date) => setState(() => _dob = date),
///   lastDate: DateTime.now(),
/// )
///
/// // Date range limiting
/// AppDatePicker(
///   label: 'Invoice Date',
///   placeholder: 'Pick a date',
///   value: _invoiceDate,
///   onChanged: cubit.setInvoiceDate,
///   firstDate: DateTime.now(),
///   lastDate: DateTime.now().add(const Duration(days: 365)),
/// )
///
/// // Custom display format
/// AppDatePicker(
///   label: 'Start Date',
///   value: _start,
///   displayFormat: 'MMMM d, yyyy',
///   onChanged: (d) => setState(() => _start = d),
/// )
/// ```
class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.onChanged,
    this.value,
    this.label,
    this.placeholder = 'Select date',
    this.displayFormat = 'MMM d, yyyy',
    this.firstDate,
    this.lastDate,
    this.enabled = true,
  });

  /// Currently selected date, or `null`.
  final DateTime? value;

  /// Called when the user confirms a date selection.
  final ValueChanged<DateTime> onChanged;

  /// Optional label above the trigger.
  final String? label;

  /// Placeholder text shown when [value] is null.
  final String placeholder;

  /// `intl` date format pattern used to display the selected date.
  /// Defaults to `'MMM d, yyyy'` → `Jan 15, 2025`.
  final String displayFormat;

  /// Earliest selectable date. Defaults to 100 years ago.
  final DateTime? firstDate;

  /// Latest selectable date. Defaults to 100 years from now.
  final DateTime? lastDate;

  /// Whether the trigger is interactive. Defaults to `true`.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    final displayText = value != null
        ? DateFormat(displayFormat).format(value!)
        : null;

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
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18.w,
                  color: colors.textTertiary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    displayText ?? placeholder,
                    style: fonts.textMdRegular.copyWith(
                      color: displayText != null
                          ? colors.textPrimary
                          : colors.textTertiary,
                    ),
                  ),
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
    final effective = value ?? DateTime.now();
    DateTime picked = effective;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.bgB0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppSheetHandle(),
                    if (label != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          label!,
                          style: fonts.textLgBold
                              .copyWith(color: colors.textPrimary),
                        ),
                      ),
                    SizedBox(height: 8.h),
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: colors.brandDefault,
                              onPrimary: Colors.white,
                              surface: colors.bgB0,
                              onSurface: colors.textPrimary,
                            ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: picked,
                        firstDate: firstDate ??
                            DateTime.now()
                                .subtract(const Duration(days: 36500)),
                        lastDate: lastDate ??
                            DateTime.now()
                                .add(const Duration(days: 36500)),
                        onDateChanged: (d) =>
                            setModalState(() => picked = d),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    PrimaryButton(
                      text: 'Confirm',
                      isEnabled: true,
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        onChanged(picked);
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
