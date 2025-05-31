part of 'payment_tracker.dart';

class PayAsYouGoContractPaymentTracker extends PaymentTracker {
  final PaymentStepStatus clientApprovalStatus;
  final PaymentStepStatus invoiceCreationStatus;

  final DateTime clientApprovedAt;
  final DateTime invoiceCreatedAt;

  const PayAsYouGoContractPaymentTracker({
    required super.createdAt,
    required this.clientApprovalStatus,
    required this.invoiceCreationStatus,
    required super.paymentConfirmationStatus,
    required super.processPaymentStatus,
    required super.paymentReceivedStatus,
    required super.paymentConfirmationDueDate,
    required this.clientApprovedAt,
    required this.invoiceCreatedAt,
    required super.paymentConfirmedAt,
    required super.paymentProcessedAt,
    required super.paymentReceivedAt,
  });

  @override
  PayAsYouGoContractPaymentTracker copyWith({
    DateTime? createdAt,
    PaymentStepStatus? clientApprovalStatus,
    PaymentStepStatus? invoiceCreationStatus,
    PaymentStepStatus? paymentConfirmationStatus,
    PaymentStepStatus? processPaymentStatus,
    PaymentStepStatus? paymentReceivedStatus,
    DateTime? paymentConfirmationDueDate,
    DateTime? clientApprovedAt,
    DateTime? invoiceCreatedAt,
    DateTime? paymentConfirmedAt,
    DateTime? paymentProcessedAt,
    DateTime? paymentReceivedAt,
  }) {
    return PayAsYouGoContractPaymentTracker(
      createdAt: createdAt ?? this.createdAt,
      clientApprovalStatus: clientApprovalStatus ?? this.clientApprovalStatus,
      invoiceCreationStatus: invoiceCreationStatus ?? this.invoiceCreationStatus,
      paymentConfirmationStatus: paymentConfirmationStatus ?? this.paymentConfirmationStatus,
      processPaymentStatus: processPaymentStatus ?? this.processPaymentStatus,
      paymentReceivedStatus: paymentReceivedStatus ?? this.paymentReceivedStatus,
      paymentConfirmationDueDate: paymentConfirmationDueDate ?? this.paymentConfirmationDueDate,
      clientApprovedAt: clientApprovedAt ?? this.clientApprovedAt,
      invoiceCreatedAt: invoiceCreatedAt ?? this.invoiceCreatedAt,
      paymentConfirmedAt: paymentConfirmedAt ?? this.paymentConfirmedAt,
      paymentProcessedAt: paymentProcessedAt ?? this.paymentProcessedAt,
      paymentReceivedAt: paymentReceivedAt ?? this.paymentReceivedAt,
    );
  }
}
