import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/attachment_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/date_selector.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/submission_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/success_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/time_record_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/work_description_field.dart';
import 'package:flutter/material.dart';

import '../../data/models/submitted_timesheet.dart';
import '../../data/models/time_record.dart';

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

  void _removeAttachment() {
    setState(() {
      attachmentName = null;
    });
  }

  void _addTimeRecord() {
    // Add new time record logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add time record functionality not implemented yet'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _editTimeRecord(int index) {
    // Edit time record logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit time record functionality not implemented yet'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteTimeRecord(int index) {
    setState(() {
      timeRecords.removeAt(index);
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

    // Show success bottom sheet
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => SuccessBottomSheet(),
    );

    Navigator.pop(context);
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Resubmit hours worked'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rejection Reason Banner
            if (widget.timesheet.rejectionReason != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(bottom: 24.0),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for rejection',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.timesheet.rejectionReason!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: _addTimeRecord,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Add record',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Time Records
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
              onUpload: () {
                setState(() {
                  attachmentName = 'File name';
                });
              },
              onRemove: _removeAttachment,
            ),
            SizedBox(height: 24.0),

            // Submission Summary
            SubmissionSummary(
              totalHours: timeRecords.fold(
                Duration.zero,
                (total, record) => total + record.duration,
              ),
              hourlyRate: widget.timesheet.hourlyRate,
              currency: widget.timesheet.currency,
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _submitHours,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6366F1),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            'Submit hours worked',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
