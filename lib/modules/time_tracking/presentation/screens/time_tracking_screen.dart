import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_entry.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_tracking_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/calendar_week_view.dart';
import '../widgets/time_entry_card.dart';
import '../widgets/time_tracking_summary_card.dart';

@RoutePage()
class TimeTrackingScreen extends StatefulWidget {
  final TimeTrackingContract contract;

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
  DateTime selectedDate = DateTime(2025, 1, 12);

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
    timeEntries.clear();
    hasWorkSubmitted = false;

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
            status: TimeOffStatus.approved,
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
            status: TimeOffStatus.rejected,
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
            status: TimeOffStatus.pending,
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
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Time tracking',
          actions: [],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.only(
                top: 10.sp,
                left: 16.sp,
                right: 12.sp,
                bottom: 10.sp,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: context.theme.colors.bgB0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: context.theme.colors.strokeSecondary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: GestureDetector(
                onTap: _showFilterBottomSheet,
                child: Row(
                  children: [
                    Text(
                      'Showing for: ',
                      style: context.theme.fonts.textMdRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        selectedDateRange,
                        style: context.theme.fonts.textMdMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: context.theme.colors.textPrimary,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          ),
          TimeTrackingSummaryCard(summary: summary),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: ShapeDecoration(
                color: context.theme.colors.bgB0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                shadows: [
                  BoxShadow(
                    color: context.theme.colors.textSecondary,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    spreadRadius: -5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarWeekView(
                    startDate: summary.startDate,
                    endDate: summary.endDate,
                    selectedDate: selectedDate,
                    onDateSelected: _onDateSelected,
                  ),
                  SizedBox(height: 5.0),
                  hasWorkSubmitted
                      ? _buildTimeEntriesList()
                      : _buildEmptyState(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildTimeEntriesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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

    context.router.push(SubmittedHoursDetailRoute(timesheet: submittedTimesheet)).then((_) {
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
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: ShapeDecoration(
        color: const Color(0x0A18181B) /* FILL-TERTIARY */,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      SizedBox(
                        width: 287,
                        child: Text(
                          'You have no worked hours submitted',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF18181B) /* TEXT-PRIMARY */,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: PrimaryButton(
        text: hasWorkSubmitted ? 'Clear hours' : 'Submit hours',
        enableShine: false,
        onPressed: () {
          if (hasWorkSubmitted) {
            setState(() {
              hasWorkSubmitted = false;
              _initializeData();
            });
          } else {
            context.router.push(SubmitHoursRoute(contract: widget.contract)).then((result) {
              if (result != null) {
                setState(() {
                  hasWorkSubmitted = true;
                  _initializeData();
                });
              }
            });
          }
        },
      ),
    );
  }
}
