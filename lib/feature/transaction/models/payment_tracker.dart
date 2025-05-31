import 'enums.dart';
part 'invoice_payment_tracker.dart';
part 'fixed_contract_payment_tracker.dart';
part 'milestone_contract_payment_tracker.dart';
part 'pay_as_you_go_contract_payment_tracker.dart';

sealed class PaymentTracker {
  final DateTime createdAt;

  final PaymentStepStatus paymentConfirmationStatus;
  final PaymentStepStatus processPaymentStatus;
  final PaymentStepStatus paymentReceivedStatus;

  final DateTime paymentConfirmationDueDate;

  final DateTime paymentConfirmedAt;
  final DateTime paymentProcessedAt;
  final DateTime paymentReceivedAt;

  const PaymentTracker({
    required this.createdAt,
    required this.paymentConfirmationStatus,
    required this.processPaymentStatus,
    required this.paymentReceivedStatus,
    required this.paymentConfirmationDueDate,
    required this.paymentConfirmedAt,
    required this.paymentProcessedAt,
    required this.paymentReceivedAt,
  });

  PaymentTracker copyWith({
    DateTime? createdAt,
    PaymentStepStatus? paymentConfirmationStatus,
    PaymentStepStatus? processPaymentStatus,
    PaymentStepStatus? paymentReceivedStatus,
    DateTime? paymentConfirmationDueDate,
    DateTime? paymentConfirmedAt,
    DateTime? paymentProcessedAt,
    DateTime? paymentReceivedAt,
  });
}
