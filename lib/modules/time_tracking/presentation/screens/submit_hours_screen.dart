import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/work_submission.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/attachment_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/date_selector.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/submission_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/time_record_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/work_description_field.dart';
import 'package:flutter/material.dart';

import '../widgets/success_bottom_sheet.dart';
import 'add_time_record_screen.dart';

class SubmitHoursScreen extends StatefulWidget {
  final Contract contract;

  const SubmitHoursScreen({Key? key, required this.contract}) : super(key: key);

  @override
  _SubmitHoursScreenState createState() => _SubmitHoursScreenState();
}

class _SubmitHoursScreenState extends State<SubmitHoursScreen> {
  DateTime selectedDate = DateTime(2025, 1, 12);
  List<TimeRecord> timeRecords = [];
  TextEditingController workDescriptionController = TextEditingController();
  String? attachmentName;

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
      hourlyRate: widget.contract.rate,
      currency: widget.contract.currency,
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

    Navigator.pop(context, submission);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Submit hours'),
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

            // Time Records or Empty State
            if (timeRecords.isEmpty)
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'You currently have no time record added.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
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
              hourlyRate: widget.contract.rate,
              currency: widget.contract.currency,
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
            'Submit worked hours',
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
