import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';

class TimeOffDetail {
  final String id;
  final TimeOffStatus status;
  final String type;
  final String reason;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime submissionDate;
  final DateTime? approvalDate;
  final DateTime? rejectionDate;
  final int totalDays;
  final String description;
  final String? attachmentFileName;
  final String contractName;
  final String contractType;
  final String clientName;
  final List<TimeOffStatusUpdate> statusUpdates;
  final String? rejectionReason;

  TimeOffDetail({
    required this.id,
    required this.status,
    required this.type,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.submissionDate,
    this.approvalDate,
    this.rejectionDate,
    required this.totalDays,
    required this.description,
    this.attachmentFileName,
    required this.contractName,
    required this.contractType,
    required this.clientName,
    required this.statusUpdates,
    this.rejectionReason,
  });

  String get dateRange {
    final start = '${startDate.day} ${_getMonthName(startDate.month)}';
    final end =
        '${endDate.day} ${_getMonthName(endDate.month)} ${endDate.year}';
    return '$start - $end';
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  String formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }
}

class TimeOffStatusUpdate {
  final String title;
  final String description;
  final DateTime timestamp;
  final TimeOffStatusUpdateType type;

  TimeOffStatusUpdate({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });
}

enum TimeOffStatusUpdateType {
  created,
  approved,
  rejected,
  inProgress,
  completed,
  awaiting,
  scheduledStart,
  scheduledEnd,
}
