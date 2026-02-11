import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

class SubmittedTimesheet {
  final String id;
  final TimeOffStatus status; // 'Approved', 'Rejected', 'Pending approval'
  final DateTime date;
  final DateTime submissionDate;
  final Duration totalHours;
  final double hourlyRate;
  final String currency;
  final double calculatedAmount;
  final String description;
  final String? attachmentName;
  final String? rejectionReason;
  final String contractName;
  final String contractType;
  final String clientName;

  SubmittedTimesheet({
    required this.id,
    required this.status,
    required this.date,
    required this.submissionDate,
    required this.totalHours,
    required this.hourlyRate,
    required this.currency,
    required this.calculatedAmount,
    required this.description,
    this.attachmentName,
    this.rejectionReason,
    required this.contractName,
    required this.contractType,
    required this.clientName,
  });

  String get formattedTotalHours {
    int hours = totalHours.inHours;
    int minutes = totalHours.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  Color get statusColor {
    switch (status) {
      case TimeOffStatus.approved:
        return Color(0xFF10B981);
      case TimeOffStatus.rejected:
        return Color(0xFFEF4444);
      case TimeOffStatus.pending:
        return Color(0xFFF59E0B);
      case TimeOffStatus.used:
        return Color(0xFF6B7280);
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case TimeOffStatus.approved:
        return Color(0xFF10B981).withOpacity(0.1);
      case TimeOffStatus.rejected:
        return Color(0xFFEF4444).withOpacity(0.1);
      case TimeOffStatus.pending:
        return Color(0xFFF59E0B).withOpacity(0.1);
      case TimeOffStatus.used:
        return Color(0xFF6B7280).withOpacity(0.1);
    }
  }
}
