import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final String selectedMonth;
  final int selectedYear;
  final String selectedDateRange;
  final Function(String month, int year, String dateRange) onFilterApplied;

  const FilterBottomSheet({
    Key? key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.selectedDateRange,
    required this.onFilterApplied,
  }) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedMonth;
  late int selectedYear;
  late String selectedDateRange;
  List<String> dynamicDateRanges = [];

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<int> years = [2024, 2025, 2026, 2027];

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedMonth;
    selectedYear = widget.selectedYear;
    selectedDateRange = widget.selectedDateRange;
    _updateDateRanges();
  }

  void _updateDateRanges() {
    int monthIndex = months.indexOf(selectedMonth) + 1;
    int lastDay = DateTime(selectedYear, monthIndex + 1, 0).day;
    
    dynamicDateRanges.clear();
    
    for (int i = 1; i <= lastDay; i += 7) {
      int endDay = i + 6;
      if (endDay > lastDay) endDay = lastDay;
      
      String startStr = '$selectedMonth ${i.toString().padLeft(2, '0')}';
      String endStr = '$selectedMonth ${endDay.toString().padLeft(2, '0')}';
      dynamicDateRanges.add('$startStr - $endStr');
    }
    
    if (!dynamicDateRanges.contains(selectedDateRange) && dynamicDateRanges.isNotEmpty) {
      selectedDateRange = dynamicDateRanges.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12.0),
              width: 48.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: context.theme.colors.strokePrimary,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          Text(
            'Filter by',
            style: context.theme.fonts.heading2Bold,
          ),
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Month & Year',
                style: context.theme.fonts.textBaseSemiBold,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB1,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: context.theme.colors.strokePrimary),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          isDense: false,
                          isExpanded: true,
                          elevation: 1,
                          dropdownColor: context.theme.colors.bgB0,
                          borderRadius: BorderRadius.circular(12.0),
                          icon: Icon(Icons.keyboard_arrow_down, color: context.theme.colors.textSecondary),
                          style: context.theme.fonts.textMdRegular.copyWith(color: context.theme.colors.textPrimary),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedMonth = newValue;
                                _updateDateRanges();
                              });
                            }
                          },
                          items: months.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB1,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: context.theme.colors.strokePrimary),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          isDense: false,
                          isExpanded: true,
                          elevation: 1,
                          dropdownColor: context.theme.colors.bgB0,
                          borderRadius: BorderRadius.circular(12.0),
                          icon: Icon(Icons.keyboard_arrow_down, color: context.theme.colors.textSecondary),
                          style: context.theme.fonts.textMdRegular.copyWith(color: context.theme.colors.textPrimary),
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedYear = newValue;
                                _updateDateRanges();
                              });
                            }
                          },
                          items: years.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
            ],
          ),
          Divider(
            color: context.theme.colors.strokeSecondary,
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date Range',
                style: context.theme.fonts.textBaseSemiBold,
              ),
              const SizedBox(height: 16.0),
              ...dynamicDateRanges
                  .map((range) => _buildDateRangeOption(range, context))
                  .toList(),
              const SizedBox(height: 32.0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Clear all',
                    backgroundColor: context.theme.colors.fillTertiary,
                    borderColor: Colors.transparent,
                    enableShine: false,
                    textColor: context.theme.colors.textPrimary,
                    onPressed: () {
                      setState(() {
                        selectedMonth = 'January';
                        selectedYear = 2025;
                        selectedDateRange = 'January 08 - January 14';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: SecondaryButton(
                    text: 'Show results',
                    backgroundColor: context.theme.colors.brandDefault,
                    borderColor: Colors.transparent,
                    enableShine: false,
                    textColor: context.theme.colors.contrastWhite,
                    onPressed: () {
                      widget.onFilterApplied(
                          selectedMonth, selectedYear, selectedDateRange);
                      context.router.maybePop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeOption(String range, BuildContext context) {
    bool isSelected = range == selectedDateRange;

    return InkWell(
      onTap: () {
        setState(() {
          selectedDateRange = range;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              range,
              style: context.theme.fonts.textMdMedium.copyWith(
                color: context.theme.colors.textPrimary,
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.colors.bgB1,
                border: Border.all(
                  color: isSelected
                      ? context.theme.colors.brandDefault
                      : context.theme.colors.strokePrimary,
                  width: isSelected ? 5.5 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
