import 'package:intl/intl.dart';
import 'work_record.dart';

enum ContractType { fixedRate, milestone, payAsYouGo }

enum PaymentStatus {
  pending,
  approved,
  overdue,
  paid,
  pendingSubmission,
  pendingApproval,
  awaitingPayment,
  rejected,
}

class PayCycleContract {
  final String id;
  final String title;
  final ContractType type;
  final String rate;
  final String frequency;
  final bool isActive;
  final String? clientName;
  final List<Milestone>? milestones;
  final List<WorkSubmission>? workSubmissions;

  PayCycleContract({
    required this.id,
    required this.title,
    required this.type,
    required this.rate,
    required this.frequency,
    required this.isActive,
    this.clientName,
    this.milestones,
    this.workSubmissions,
  });
}

class WorkSubmission {
  final String id;
  final double quantity; // hours, days, etc.
  final String unit; // 'hours', 'days', etc.
  final double amount;
  final String currency;
  final DateTime submissionDate;
  final DateTime workDate;
  final PaymentStatus status;
  final String? description;
  final String? attachmentPath;
  final String? invoiceNumber;
  final String? rejectionReason;
  final List<WorkBreakdownItem>? breakdown;
  final List<WorkRecord>? records;

  WorkSubmission({
    required this.id,
    required this.quantity,
    required this.unit,
    required this.amount,
    required this.currency,
    required this.submissionDate,
    required this.workDate,
    required this.status,
    this.description,
    this.attachmentPath,
    this.invoiceNumber,
    this.rejectionReason,
    this.breakdown,
    this.records,
  });
}

class WorkBreakdownItem {
  final String label;
  final String timeRange;
  final String duration;

  WorkBreakdownItem({
    required this.label,
    required this.timeRange,
    required this.duration,
  });
}

class Payout {
  final String id;
  final String invoiceNumber;
  final PaymentStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime submissionDate;
  final DateTime dueDate;
  final double amount;
  final String currency;
  final String contractId;
  final String contractTitle;
  final String clientName;

  Payout({
    required this.id,
    required this.invoiceNumber,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.submissionDate,
    required this.dueDate,
    required this.amount,
    required this.currency,
    required this.contractId,
    required this.contractTitle,
    required this.clientName,
  });
}

class Milestone {
  final String id;
  final String title;
  final double amount;
  final String currency;
  final DateTime? dueDate;
  final DateTime? submissionDate;
  final PaymentStatus status;
  final String invoiceNumber;
  final String? description;
  final String? attachmentPath;

  Milestone({
    required this.id,
    required this.title,
    required this.amount,
    required this.currency,
    this.dueDate,
    this.submissionDate,
    required this.status,
    this.invoiceNumber = '',
    this.description,
    this.attachmentPath,
  });
}

extension ContractTypeExtension on ContractType {
  String get displayName {
    switch (this) {
      case ContractType.fixedRate:
        return 'Fixed Rate';
      case ContractType.milestone:
        return 'Milestone';
      case ContractType.payAsYouGo:
        return 'Pay As You Go';
    }
  }
}

extension DateTimeExtension on DateTime {
  String get dayMonth {
    return DateFormat('d MMM').format(this);
  }

  String get dayMonthYear {
    return DateFormat('d MMM yyyy').format(this);
  }
}
