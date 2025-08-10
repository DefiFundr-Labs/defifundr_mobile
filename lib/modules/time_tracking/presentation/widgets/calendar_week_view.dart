import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarWeekView extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWeekView({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildWeekDays(context),
      ),
    );
  }

  List<Widget> _buildWeekDays(BuildContext context) {
    List<Widget> days = [];
    List<String> dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    List<int> daysWithWork = [10, 11, 12];

    for (int i = 0; i < 7; i++) {
      DateTime dayDate = startDate.add(Duration(days: i));
      bool isSelected = dayDate.day == selectedDate.day;
      bool hasWork = daysWithWork.contains(dayDate.day);

      days.add(
        GestureDetector(
          onTap: () => onDateSelected(dayDate),
          child: Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.theme.colors.brandDefault
                  : context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(8.0),
              border: hasWork && !isSelected
                  ? Border.all(
                      color: context.theme.colors.brandDefault, width: 1)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayNames[i],
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 12.sp,
                    color: isSelected
                        ? context.theme.colors.contrastWhite
                        : context.theme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  dayDate.day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? context.theme.colors.contrastWhite
                        : hasWork
                            ? context.theme.colors.textSecondary
                            : context.theme.colors.textSecondary,
                  ),
                ),
                if (hasWork && !isSelected)
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.theme.colors.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return days;
  }
}
