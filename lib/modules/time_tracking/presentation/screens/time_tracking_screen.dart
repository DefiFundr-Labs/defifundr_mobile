import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_entry.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_tracking_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submit_hours_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submitted_hours_detail_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../widgets/calendar_week_view.dart';
import '../widgets/time_entry_card.dart';
import '../widgets/time_tracking_summary_card.dart';

class TimeTrackingScreen extends StatefulWidget {
  final Contract contract;

  const TimeTrackingScreen({Key? key, required this.contract})
      : super(key: key);

  @override
  _TimeTrackingScreenState createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  late TimeTrackingSummary summary;
  List<TimeEntry> timeEntries = [];
  bool hasWorkSubmitted = false;
  String selectedMonth = 'January';
  int selectedYear = 2025;
  String selectedDateRange = 'January 08 - January 14';
  DateTime selectedDate = DateTime(2025, 1, 12); // Track selected date

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    summary = TimeTrackingSummary(
      totalHours: 120,
      approvedHours: 100,
      pendingHours: 18,
      deniedHours: 2,
      startDate: DateTime(2025, 1, 8),
      endDate: DateTime(2025, 1, 14),
    );

    _updateTimeEntriesForSelectedDate();
  }

  void _updateTimeEntriesForSelectedDate() {
    // Clear previous entries
    timeEntries.clear();
    hasWorkSubmitted = false;

    // Define which days have work submitted with different statuses
    Map<int, Map<String, dynamic>> daysWithWork = {
      10: {
        'status': 'Approved',
        'entries': [
          TimeEntry(
            id: '2',
            contractId: widget.contract.id,
            startTime: DateTime(2025, 1, 10, 9, 0),
            endTime: DateTime(2025, 1, 10, 17, 30),
            amount: 178.5,
            currency: 'USDT',
            status: 'Approved',
            duration: Duration(hours: 8, minutes: 30),
          ),
        ]
      },
      11: {
        'status': 'Rejected',
        'entries': [
          TimeEntry(
            id: '3',
            contractId: widget.contract.id,
            startTime: DateTime(2025, 1, 11, 10, 0),
            endTime: DateTime(2025, 1, 11, 18, 0),
            amount: 168,
            currency: 'USDT',
            status: 'Rejected',
            duration: Duration(hours: 8, minutes: 0),
          ),
        ]
      },
      12: {
        'status': 'Pending approval',
        'entries': [
          TimeEntry(
            id: '1',
            contractId: widget.contract.id,
            startTime: DateTime(2025, 1, 12, 12, 40),
            endTime: DateTime(2025, 1, 12, 19, 39),
            amount: 147,
            currency: 'USDT',
            status: 'Pending approval',
            duration: Duration(hours: 6, minutes: 59),
          ),
        ]
      }
    };

    if (daysWithWork.containsKey(selectedDate.day)) {
      hasWorkSubmitted = true;
      final dayData = daysWithWork[selectedDate.day]!;
      timeEntries = List<TimeEntry>.from(dayData['entries']);
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      _updateTimeEntriesForSelectedDate();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedMonth: selectedMonth,
        selectedYear: selectedYear,
        selectedDateRange: selectedDateRange,
        onFilterApplied: (month, year, dateRange) {
          setState(() {
            selectedMonth = month;
            selectedYear = year;
            selectedDateRange = dateRange;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time tracking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Date Range Selector
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: _showFilterBottomSheet,
              child: Row(
                children: [
                  Text(
                    'Showing for: ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Expanded(
                    child: Text(
                      selectedDateRange,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
          // Summary Cards
          TimeTrackingSummaryCard(summary: summary),
          SizedBox(height: 16.0),
          // Calendar Week View
          CalendarWeekView(
            startDate: summary.startDate,
            endDate: summary.endDate,
            selectedDate: selectedDate,
            onDateSelected: _onDateSelected,
          ),
          SizedBox(height: 24.0),
          // Time Entries or Empty State
          Expanded(
            child:
                hasWorkSubmitted ? _buildTimeEntriesList() : _buildEmptyState(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildTimeEntriesList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: timeEntries.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _navigateToSubmittedHours(timeEntries[index]),
          child: TimeEntryCard(
            timeEntry: timeEntries[index],
            contract: widget.contract,
          ),
        );
      },
    );
  }

  void _navigateToSubmittedHours(TimeEntry timeEntry) {
    // Create a SubmittedTimesheet from the TimeEntry
    final submittedTimesheet = SubmittedTimesheet(
      id: timeEntry.id,
      status: timeEntry.status,
      date: selectedDate,
      submissionDate: selectedDate,
      totalHours: timeEntry.duration,
      hourlyRate: widget.contract.rate,
      currency: widget.contract.currency,
      calculatedAmount: timeEntry.amount,
      description: _getDescriptionForEntry(timeEntry),
      attachmentName: 'File name.pdf',
      rejectionReason: timeEntry.status == 'Rejected'
          ? 'Post-optimization logs showed a spike in timeout errors, and the performance gains weren\'t consistent under load.'
          : null,
      contractName: widget.contract.title,
      contractType: widget.contract.type,
      clientName: 'Adegboyega Oluwagbemiro',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmittedHoursDetailScreen(
          timesheet: submittedTimesheet,
        ),
      ),
    ).then((_) {
      // Refresh the data when returning from detail screen
      setState(() {
        _updateTimeEntriesForSelectedDate();
      });
    });
  }

  String _getDescriptionForEntry(TimeEntry timeEntry) {
    switch (timeEntry.status) {
      case 'Approved':
        return 'Completed user authentication system with OAuth integration and security improvements.';
      case 'Rejected':
        return 'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.';
      case 'Pending approval':
        return 'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.';
      default:
        return 'Work completed as per requirements.';
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'You have no worked hours submitted',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          if (hasWorkSubmitted) {
            // Clear existing work
            setState(() {
              hasWorkSubmitted = false;
              _initializeData();
            });
          } else {
            // Navigate to submit hours screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubmitHoursScreen(
                  contract: widget.contract,
                ),
              ),
            ).then((result) {
              if (result != null) {
                setState(() {
                  hasWorkSubmitted = true;
                  _initializeData();
                });
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          hasWorkSubmitted ? 'Clear hours' : 'Submit hours',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
