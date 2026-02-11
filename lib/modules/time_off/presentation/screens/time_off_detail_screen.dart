import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:flutter/material.dart';

import '../widgets/status_chip.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()

class TimeOffDetailScreen extends StatelessWidget {
  final TimeOffDetail timeOffDetail;

  const TimeOffDetailScreen({
    Key? key,
    required this.timeOffDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.router.maybePop(),
        ),
        title: const Text(
          'Time off details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status
                  _buildDetailRow(
                    'Status',
                    '',
                    trailing: StatusChip(status: timeOffDetail.status),
                  ),

                  // Type
                  _buildDetailRow('Type', timeOffDetail.type),

                  // Reason
                  _buildDetailRow('Reason', timeOffDetail.reason),

                  // Dates
                  _buildDetailRow('Dates', timeOffDetail.dateRange),

                  // Submission date
                  _buildDetailRow('Submission date',
                      timeOffDetail.formatDate(timeOffDetail.submissionDate)),

                  // Approval/Rejection date based on status
                  if (timeOffDetail.status == TimeOffStatus.approved &&
                      timeOffDetail.approvalDate != null)
                    _buildDetailRow('Approval date',
                        timeOffDetail.formatDate(timeOffDetail.approvalDate!)),

                  if (timeOffDetail.status == TimeOffStatus.rejected &&
                      timeOffDetail.rejectionDate != null)
                    _buildDetailRow('Rejection date',
                        timeOffDetail.formatDate(timeOffDetail.rejectionDate!)),

                  if (timeOffDetail.status == TimeOffStatus.pending)
                    _buildDetailRow('Approval date', '--'),

                  // Total time off
                  _buildDetailRow(
                      'Total time off', '${timeOffDetail.totalDays} days'),

                  const SizedBox(height: 24),

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        timeOffDetail.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Attachment
                  if (timeOffDetail.attachmentFileName != null)
                    _buildDetailRow(
                      'Attachment',
                      '',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.description_outlined,
                                size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 6),
                            Text(
                              timeOffDetail.attachmentFileName!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Rejection reason (only for rejected status)
                  if (timeOffDetail.status == TimeOffStatus.rejected &&
                      timeOffDetail.rejectionReason != null) ...[
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reason for rejection',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          timeOffDetail.rejectionReason!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Contract details
                  _buildDetailRow('Contract', timeOffDetail.contractName,
                      trailing: Icon(Icons.open_in_new,
                          size: 16, color: Colors.grey.shade600)),

                  _buildDetailRow('Contract Type', timeOffDetail.contractType),

                  _buildDetailRow('Client', timeOffDetail.clientName),

                  const SizedBox(height: 32),

                  // Status timeline
                  _buildStatusTimeline(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom buttons
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
    return Column(
      children: timeOffDetail.statusUpdates.asMap().entries.map((entry) {
        final index = entry.key;
        final update = entry.value;
        final isLast = index == timeOffDetail.statusUpdates.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getTimelineIconColor(update.type),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getTimelineIcon(update.type),
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey.shade200,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    update.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    update.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (!isLast) const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Color _getTimelineIconColor(TimeOffStatusUpdateType type) {
    switch (type) {
      case TimeOffStatusUpdateType.created:
      case TimeOffStatusUpdateType.approved:
      case TimeOffStatusUpdateType.inProgress:
      case TimeOffStatusUpdateType.completed:
        return Colors.green;
      case TimeOffStatusUpdateType.rejected:
        return Colors.red;
      case TimeOffStatusUpdateType.awaiting:
        return Colors.orange;
      case TimeOffStatusUpdateType.scheduledStart:
      case TimeOffStatusUpdateType.scheduledEnd:
        return Colors.grey;
    }
  }

  IconData _getTimelineIcon(TimeOffStatusUpdateType type) {
    switch (type) {
      case TimeOffStatusUpdateType.created:
      case TimeOffStatusUpdateType.approved:
      case TimeOffStatusUpdateType.inProgress:
      case TimeOffStatusUpdateType.completed:
        return Icons.check;
      case TimeOffStatusUpdateType.rejected:
        return Icons.close;
      case TimeOffStatusUpdateType.awaiting:
        return Icons.schedule;
      case TimeOffStatusUpdateType.scheduledStart:
      case TimeOffStatusUpdateType.scheduledEnd:
        return Icons.schedule;
    }
  }

  Widget _buildBottomButtons(BuildContext context) {
    if (timeOffDetail.status == TimeOffStatus.used) {
      return const SizedBox.shrink(); // No buttons for completed requests
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Cancel request functionality
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: const Text(
                'Cancel request',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Edit or request change functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _getActionButtonText(),
                style: const TextStyle(
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

  String _getActionButtonText() {
    switch (timeOffDetail.status) {
      case TimeOffStatus.pending:
        return 'Edit request';
      case TimeOffStatus.approved:
        return 'Request change';
      case TimeOffStatus.rejected:
      case TimeOffStatus.used:
        return 'Edit request';
    }
  }
}

// Sample data factory for testing
class TimeOffDetailFactory {
  static TimeOffDetail createPendingRequest() {
    return TimeOffDetail(
      id: '1',
      status: TimeOffStatus.pending,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 6, 3),
      endDate: DateTime(2025, 6, 7),
      submissionDate: DateTime(2025, 5, 21),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Awaiting client approval',
          description: 'Leave is linked to the approval of your submission',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.awaiting,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should start on 20 December 2024.',
          description: '',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.scheduledStart,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createRejectedRequest() {
    return TimeOffDetail(
      id: '2',
      status: TimeOffStatus.rejected,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 3, 6),
      endDate: DateTime(2025, 3, 10),
      submissionDate: DateTime(2025, 2, 20),
      rejectionDate: DateTime(2025, 2, 24),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      rejectionReason:
          'Leave request overlaps with critical end-of-year operations and staffing requirements.',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request rejected by client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.rejected,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should start on 20 December 2024.',
          description: '',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.scheduledStart,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createApprovedRequest() {
    return TimeOffDetail(
      id: '3',
      status: TimeOffStatus.approved,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      submissionDate: DateTime(2025, 5, 16),
      approvalDate: DateTime(2025, 5, 18),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request approved & scheduled',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.approved,
        ),
        TimeOffStatusUpdate(
          title: 'Awaiting time off start date',
          description:
              'According to your time off request, your leave should start on 20 December 2024.',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.awaiting,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createUsedRequest() {
    return TimeOffDetail(
      id: '4',
      status: TimeOffStatus.used,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      submissionDate: DateTime(2025, 3, 21),
      approvalDate: DateTime(2025, 3, 24),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request approved & scheduled',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.approved,
        ),
        TimeOffStatusUpdate(
          title: 'Time off in progress',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.inProgress,
        ),
        TimeOffStatusUpdate(
          title: 'Time off completed',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.completed,
        ),
      ],
    );
  }
}
