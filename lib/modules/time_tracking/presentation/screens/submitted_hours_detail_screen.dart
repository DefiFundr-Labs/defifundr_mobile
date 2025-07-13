import 'package:flutter/material.dart';

import '../../data/models/submitted_timesheet.dart';
import '../widgets/delete_submission_bottom_sheet.dart';
import 'resubmit_hours_screen.dart';

class SubmittedHoursDetailScreen extends StatelessWidget {
  final SubmittedTimesheet timesheet;

  const SubmittedHoursDetailScreen({Key? key, required this.timesheet})
      : super(key: key);

  String _formatDate(DateTime date) {
    const months = [
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

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeleteSubmissionBottomSheet(
        timesheet: timesheet,
        onConfirmDelete: () {
          Navigator.pop(context); // Close bottom sheet
          Navigator.pop(context); // Go back to previous screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Submission deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _handleEditResubmit(BuildContext context) {
    if (timesheet.status == 'Rejected') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResubmitHoursScreen(timesheet: timesheet),
        ),
      );
    } else {
      // Handle edit for pending submissions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Edit functionality not implemented yet'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Submitted hours'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status and Date Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'Status',
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: timesheet.statusBackgroundColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              timesheet.status,
                              style: TextStyle(
                                fontSize: 12,
                                color: timesheet.statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Date', _formatDate(timesheet.date)),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Submission date',
                            _formatDate(timesheet.submissionDate)),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                          'Total hours worked',
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                timesheet.formattedTotalHours,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[600], size: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Hourly rate',
                            '${timesheet.hourlyRate.toInt()} ${timesheet.currency}'),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Calculated amount',
                            '${timesheet.calculatedAmount.toInt()} ${timesheet.currency}'),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.0),

                  // Description Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          timesheet.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.0),

                  // Attachment Section
                  if (timesheet.attachmentName != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildDetailRow(
                        'Attachment',
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.insert_drive_file,
                                  color: Colors.grey[600], size: 16),
                              SizedBox(width: 8.0),
                              Text(
                                timesheet.attachmentName!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Rejection Reason Section (only for rejected submissions)
                  if (timesheet.status == 'Rejected' &&
                      timesheet.rejectionReason != null) ...[
                    SizedBox(height: 24.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for rejection',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            timesheet.rejectionReason!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[700],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 24.0),

                  // Contract Information
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'Contract',
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  timesheet.contractName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(Icons.open_in_new,
                                  color: Colors.grey[600], size: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Contract Type', timesheet.contractType),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Client', timesheet.clientName),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          flex: 3,
          child: value is Widget
              ? value
              : Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    if (timesheet.status == 'Approved') {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: OutlinedButton(
          onPressed: () => _showDeleteConfirmation(context),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            side: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            'Delete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showDeleteConfirmation(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _handleEditResubmit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  timesheet.status == 'Rejected' ? 'Edit & resubmit' : 'Edit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
