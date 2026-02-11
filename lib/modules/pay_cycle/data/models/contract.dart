import 'package:intl/intl.dart';

enum ContractType { fixedRate, milestone, payAsYouGo }

enum PaymentStatus { pending, approved, overdue, paid }

class PayCycleContract {
  final String id;
  final String title;
  final ContractType type;
  final String rate;
  final String frequency;
  final bool isActive;
  final String? clientName;

  PayCycleContract({
    required this.id,
    required this.title,
    required this.type,
    required this.rate,
    required this.frequency,
    required this.isActive,
    this.clientName,
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
