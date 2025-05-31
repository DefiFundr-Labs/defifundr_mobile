import 'enums.dart';

class MilestoneContractPaymentTracker {
  final DateTime createdAt;

  final PaymentStepStatus clientApprovalStatus;
  final PaymentStepStatus invoiceCreationStatus;
  final PaymentStepStatus paymentConfirmationStatus;
  final PaymentStepStatus processPaymentStatus;
  final PaymentStepStatus paymentReceivedStatus;

  final DateTime paymentConfirmationDueDate;

  final DateTime clientApprovedAt;
  final DateTime invoiceCreatedAt;
  final DateTime paymentConfirmedAt;
  final DateTime paymentProcessedAt;
  final DateTime paymentReceivedAt;

  const MilestoneContractPaymentTracker({
    required this.createdAt,
    required this.clientApprovalStatus,
    required this.invoiceCreationStatus,
    required this.paymentConfirmationStatus,
    required this.processPaymentStatus,
    required this.paymentReceivedStatus,
    required this.paymentConfirmationDueDate,
    required this.clientApprovedAt,
    required this.invoiceCreatedAt,
    required this.paymentConfirmedAt,
    required this.paymentProcessedAt,
    required this.paymentReceivedAt,
  });

  MilestoneContractPaymentTracker copyWith({
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
    return MilestoneContractPaymentTracker(
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
