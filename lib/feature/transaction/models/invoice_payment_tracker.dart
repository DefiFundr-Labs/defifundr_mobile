import 'enums.dart';

class InvoicePaymentTracker {
  final DateTime createdAt;
  final PaymentStepStatus paymentConfirmationStatus;
  final PaymentStepStatus paymentProcessingStatus;
  final PaymentStepStatus paymentReceivedStatus;

  final DateTime paymentConfirmationDueDate;
  final DateTime paymentConfirmedAt;
  final DateTime paymentProcessedAt;
  final DateTime paymentReceivedAt;

  const InvoicePaymentTracker({
    required this.createdAt,
    required this.paymentConfirmationStatus,
    required this.paymentProcessingStatus,
    required this.paymentReceivedStatus,
    required this.paymentConfirmationDueDate,
    required this.paymentConfirmedAt,
    required this.paymentProcessedAt,
    required this.paymentReceivedAt,
  });

  InvoicePaymentTracker copyWith({
    DateTime? createdAt,
    PaymentStepStatus? paymentConfirmationStatus,
    PaymentStepStatus? paymentProcessingStatus,
    PaymentStepStatus? paymentReceivedStatus,
    DateTime? paymentConfirmationDueDate,
    DateTime? paymentConfirmedAt,
    DateTime? paymentProcessedAt,
    DateTime? paymentReceivedAt,
  }) {
    return InvoicePaymentTracker(
      createdAt: createdAt ?? this.createdAt,
      paymentConfirmationStatus: paymentConfirmationStatus ?? this.paymentConfirmationStatus,
      paymentProcessingStatus: paymentProcessingStatus ?? this.paymentProcessingStatus,
      paymentReceivedStatus: paymentReceivedStatus ?? this.paymentReceivedStatus,
      paymentConfirmationDueDate: paymentConfirmationDueDate ?? this.paymentConfirmationDueDate,
      paymentConfirmedAt: paymentConfirmedAt ?? this.paymentConfirmedAt,
      paymentProcessedAt: paymentProcessedAt ?? this.paymentProcessedAt,
      paymentReceivedAt: paymentReceivedAt ?? this.paymentReceivedAt,
    );
  }
}
