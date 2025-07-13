import 'package:flutter/material.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildWeekDays(),
      ),
    );
  }

  List<Widget> _buildWeekDays() {
    List<Widget> days = [];
    List<String> dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    // Days with work submitted (visual indicators)
    List<int> daysWithWork = [
      10,
      11,
      12
    ]; // Jan 10 (Tuesday), Jan 11 (Wednesday), Jan 12 (Friday)

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
              color: isSelected ? Color(0xFF6366F1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: hasWork && !isSelected
                  ? Border.all(color: Color(0xFF6366F1), width: 1)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayNames[i],
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  dayDate.day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : hasWork
                            ? Color(0xFF6366F1)
                            : Colors.black87,
                  ),
                ),
                if (hasWork && !isSelected)
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xFF6366F1),
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
