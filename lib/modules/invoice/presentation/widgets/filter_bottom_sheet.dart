import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Set<String> selectedStatuses = {'All'};
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        color: isLight ? context.theme.colors.bgB0 : context.theme.colors.bgB1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by',
                  style: context.theme.fonts.heading2Bold.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
                SizedBox(height: 15.h),
                _buildStatusSection(),
                SizedBox(height: 20.h),
                Divider(
                  color: context.theme.colors.strokePrimary,
                  thickness: 1,
                ),
                SizedBox(height: 20.h),
                _buildDateSection(),
                const SizedBox(height: 40),
                _buildActionButtons(),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 48,
      height: 5,
      decoration: BoxDecoration(
        color: context.theme.colors.textPrimary.withAlpha(16),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: context.theme.fonts.textBaseSemiBold.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: context.theme.colors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatusOption(
          'All',
          context.theme.colors.brandFill,
          context.theme.colors.brandDefaultContrast,
          context.theme.colors.brandStroke,
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          'Pending',
          context.theme.colors.orangeFill,
          context.theme.colors.orangeDefault,
          context.theme.colors.orangeStroke,
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          'Paid',
          context.theme.colors.greenFill,
          context.theme.colors.greenDefault,
          context.theme.colors.greenStroke,
        ),
        const SizedBox(height: 12),
        _buildStatusOption(
          'Overdue',
          context.theme.colors.redFill,
          context.theme.colors.redDefault,
          context.theme.colors.redStroke,
        ),
      ],
    );
  }

  Widget _buildStatusOption(String status, Color backgroundColor,
      Color textColor, Color borderColor) {
    final isSelected = selectedStatuses.contains(status);

    return GestureDetector(
      onTap: () => _toggleStatus(status),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor),
            ),
            child: Text(
              status,
              style: context.theme.fonts.textSmMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.theme.colors.brandDefault
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? context.theme.colors.brandDefault
                    : context.theme.colors.strokePrimary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    size: 16.sp,
                    color: context.theme.colors.bgB2,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice Date',
          style: context.theme.fonts.textBaseSemiBold.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: context.theme.colors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDateField('From', fromDate, (date) {
                setState(() {
                  fromDate = date;
                });
              }),
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: _buildDateField('To', toDate, (date) {
                setState(() {
                  toDate = date;
                });
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? selectedDate,
      Function(DateTime?) onDateSelected) {
    return GestureDetector(
      onTap: () => _selectDate(onDateSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.colors.strokePrimary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate != null
                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                    : label,
                style: context.theme.fonts.textMdRegular.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: selectedDate != null
                      ? context.theme.colors.textPrimary
                      : context.theme.colors.textSecondary,
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.icons.calendar,
              width: 20,
              height: 20,
              color: context.theme.colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Clear all',
            fixedSize: Size(double.infinity, 48.h),
            onPressed: _clearFilters,
            enableShine: false,
            color: context.theme.colors.textSecondary.withAlpha(20),
            textColor: context.theme.colors.textPrimary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: 'Show results',
            enableShine: false,
            fixedSize: Size(double.infinity, 48.h),
            onPressed: _applyFilters,
          ),
        ),
      ],
    );
  }

  void _toggleStatus(String status) {
    setState(() {
      if (status == 'All') {
        selectedStatuses = {'All'};
      } else {
        if (selectedStatuses.contains('All')) {
          selectedStatuses.remove('All');
        }

        if (selectedStatuses.contains(status)) {
          selectedStatuses.remove(status);
          if (selectedStatuses.isEmpty) {
            selectedStatuses.add('All');
          }
        } else {
          selectedStatuses.add(status);
        }
      }
    });
  }

  Future<void> _selectDate(Function(DateTime?) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  void _clearFilters() {
    setState(() {
      selectedStatuses = {'All'};
      fromDate = null;
      toDate = null;
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'statuses': selectedStatuses,
      'fromDate': fromDate,
      'toDate': toDate,
    });
  }
}
