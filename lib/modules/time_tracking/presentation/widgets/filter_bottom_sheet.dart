import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

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

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> dateRanges = [
    'January 01 - January 07',
    'January 08 - January 14',
    'January 15 - January 21',
    'January 22 - January 28',
    'January 29 - January 31',
  ];

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedMonth;
    selectedYear = widget.selectedYear;
    selectedDateRange = widget.selectedDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.0),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          
          // Header
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'Filter by',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Month & Year Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Month & Year',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedMonth,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        selectedYear.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),

          // Date Range Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date Range',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.0),
                ...dateRanges.map((range) => _buildDateRangeOption(range)).toList(),
                SizedBox(height: 32.0),
              ],
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 40.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth = 'January';
                        selectedYear = 2025;
                        selectedDateRange = 'January 08 - January 14';
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Clear all',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onFilterApplied(selectedMonth, selectedYear, selectedDateRange);
                      context.router.maybePop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Show results',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeOption(String range) {
    bool isSelected = range == selectedDateRange;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDateRange = range;
          });
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isSelected ? Color(0xFF6366F1) : Colors.grey[200]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                range,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Color(0xFF6366F1) : Colors.black87,
                ),
              ),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF6366F1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}