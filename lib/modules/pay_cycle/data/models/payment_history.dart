import 'contract.dart';

class PaymentHistoryItem {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime submissionDate;
  final double amount;
  final String currency;
  final PaymentStatus status;

  PaymentHistoryItem({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.submissionDate,
    required this.amount,
    required this.currency,
    required this.status,
  });
}
