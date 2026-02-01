import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/work_submission.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/attachment_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/date_selector.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/submission_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/time_record_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/work_description_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/add_time_record_bottom_sheet.dart';
import '../widgets/success_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ResubmitHoursScreen extends StatefulWidget {
  final SubmittedTimesheet timesheet;

  const ResubmitHoursScreen({Key? key, required this.timesheet})
      : super(key: key);

  @override
  _ResubmitHoursScreenState createState() => _ResubmitHoursScreenState();
}

class _ResubmitHoursScreenState extends State<ResubmitHoursScreen> {
  late DateTime selectedDate;
  List<TimeRecord> timeRecords = [];
  late TextEditingController workDescriptionController;
  String? attachmentName;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.timesheet.date;
    workDescriptionController =
        TextEditingController(text: widget.timesheet.description);
    attachmentName = widget.timesheet.attachmentName;
    _initializeTimeRecords();
  }

  void _initializeTimeRecords() {
    // Create sample time records based on the original submission
    timeRecords = [
      TimeRecord(
        id: '1',
        startTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 12, 40),
        endTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 15, 40),
        type: 'Regular hours',
        duration: Duration(hours: 3),
      ),
      TimeRecord(
        id: '2',
        startTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 15, 40),
        endTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 16, 10),
        type: 'Break',
        duration: Duration(minutes: 30),
      ),
      TimeRecord(
        id: '3',
        startTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 16, 10),
        endTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 18, 10),
        type: 'Regular hours',
        duration: Duration(hours: 2),
      ),
      TimeRecord(
        id: '4',
        startTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 18, 10),
        endTime: DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 19, 39),
        type: 'Overtime',
        duration: Duration(hours: 1, minutes: 29),
      ),
    ];
  }

  @override
  void dispose() {
    workDescriptionController.dispose();
    super.dispose();
  }

  void _addTimeRecord() async {
    final result = await showModalBottomSheet<TimeRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTimeRecordBottomSheet(),
    );

    if (result != null) {
      setState(() {
        timeRecords.add(result);
      });
    }
  }

  void _editTimeRecord(int index) async {
    final result = await showModalBottomSheet<TimeRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTimeRecordBottomSheet(
        timeRecord: timeRecords[index],
      ),
    );

    if (result != null) {
      setState(() {
        timeRecords[index] = result;
      });
    }
  }

  void _deleteTimeRecord(int index) {
    setState(() {
      timeRecords.removeAt(index);
    });
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _uploadAttachment() {
    // Simulate file upload
    setState(() {
      attachmentName = 'File name';
    });
  }

  void _removeAttachment() {
    setState(() {
      attachmentName = null;
    });
  }

  void _submitHours() async {
    if (timeRecords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add at least one time record'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (workDescriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add a work description'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final submission = WorkSubmission(
      selectedDate: selectedDate,
      timeRecords: timeRecords,
      workDescription: workDescriptionController.text,
      attachmentName: attachmentName,
      hourlyRate: widget.timesheet.hourlyRate,
      currency: widget.timesheet.currency,
    );

    // Show success bottom sheet
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => SuccessBottomSheet(),
    );

    context.router.maybePop(submission);
  }

  Widget _buildRejectionReasonBanner() {
    if (widget.timesheet.rejectionReason == null) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: context.theme.colors.redDefault,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: context.theme.colors.redStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: context.theme.colors.redStroke,
                size: 20,
              ),
              SizedBox(width: 8.w),
              Text(
                'Reason for rejection',
                style: context.theme.fonts.textMdMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.redDefault,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            widget.timesheet.rejectionReason!,
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 14.sp,
              color: context.theme.colors.redDefault,
              height: 1.4,
            ),
          ),
        ],
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
          title: 'Resubmit hours',
          actions: [],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rejection Reason Banner
            _buildRejectionReasonBanner(),

            // Date Selector
            DateSelector(
              selectedDate: selectedDate,
              onDateSelected: _selectDate,
            ),
            SizedBox(height: 24.0),

            // Record Items Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Record items',
                  style: context.theme.fonts.textMdMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: _addTimeRecord,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: context.theme.colors.fillTertiary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Add record',
                      style: context.theme.fonts.textMdMedium.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Time Records or Empty State
            if (timeRecords.isEmpty)
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB0,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: context.theme.colors.strokeSecondary,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: context.theme.colors.textSecondary,
                      size: 20,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'You currently have no time record added.',
                        style: context.theme.fonts.textMdRegular.copyWith(
                          fontSize: 14.sp,
                          color: context.theme.colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...timeRecords.asMap().entries.map((entry) {
                int index = entry.key;
                TimeRecord record = entry.value;
                return TimeRecordCard(
                  timeRecord: record,
                  onEdit: () => _editTimeRecord(index),
                  onDelete: () => _deleteTimeRecord(index),
                );
              }).toList(),

            SizedBox(height: 24.0),

            // Work Description
            WorkDescriptionField(
              controller: workDescriptionController,
            ),
            SizedBox(height: 24.0),

            // Attachment Section
            AttachmentSection(
              attachmentName: attachmentName,
              onUpload: _uploadAttachment,
              onRemove: _removeAttachment,
            ),
            SizedBox(height: 24.0),

            // Submission Summary
            SubmissionSummary(
              totalHours: timeRecords.isNotEmpty
                  ? timeRecords.fold(
                      Duration.zero,
                      (total, record) => total + record.duration,
                    )
                  : Duration.zero,
              hourlyRate: widget.timesheet.hourlyRate,
              currency: widget.timesheet.currency,
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: PrimaryButton(
          onPressed: _submitHours,
          enableShine: false,
          text: 'Resubmit worked hours',
        ),
      ),
    );
  }
}
