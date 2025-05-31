part of 'payment_tracker.dart';

class InvoicePaymentTracker extends PaymentTracker {
  const InvoicePaymentTracker({
    required super.createdAt,
    required super.paymentConfirmationStatus,
    required super.processPaymentStatus,
    required super.paymentReceivedStatus,
    required super.paymentConfirmationDueDate,
    required super.paymentConfirmedAt,
    required super.paymentProcessedAt,
    required super.paymentReceivedAt,
  });

  @override
  InvoicePaymentTracker copyWith({
    DateTime? createdAt,
    PaymentStepStatus? paymentConfirmationStatus,
    PaymentStepStatus? processPaymentStatus,
    PaymentStepStatus? paymentReceivedStatus,
    DateTime? paymentConfirmationDueDate,
    DateTime? paymentConfirmedAt,
    DateTime? paymentProcessedAt,
    DateTime? paymentReceivedAt,
  }) {
    return InvoicePaymentTracker(
      createdAt: createdAt ?? this.createdAt,
      paymentConfirmationStatus: paymentConfirmationStatus ?? this.paymentConfirmationStatus,
      processPaymentStatus: processPaymentStatus ?? this.processPaymentStatus,
      paymentReceivedStatus: paymentReceivedStatus ?? this.paymentReceivedStatus,
      paymentConfirmationDueDate: paymentConfirmationDueDate ?? this.paymentConfirmationDueDate,
      paymentConfirmedAt: paymentConfirmedAt ?? this.paymentConfirmedAt,
      paymentProcessedAt: paymentProcessedAt ?? this.paymentProcessedAt,
      paymentReceivedAt: paymentReceivedAt ?? this.paymentReceivedAt,
    );
  }
}
