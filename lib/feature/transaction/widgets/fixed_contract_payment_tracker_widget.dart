import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/date_time_extension.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:defifundr_mobile/feature/transaction/models/fixed_contract_payment_tracker.dart';
import 'package:defifundr_mobile/feature/transaction/widgets/payment_status_widget.dart';
import 'package:flutter/material.dart';

class FixedContractPaymentTrackerWidget extends StatelessWidget {
  final FixedContractPaymentTracker _paymentTracker;
  const FixedContractPaymentTrackerWidget(this._paymentTracker, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.colors.bgB1, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          PaymentStatusWidget(
            status: PaymentStepStatus.completed,
            title: AppTexts.contractCycleCompleted,
            description1: _paymentTracker.createdAt.toFormattedString1(),
          ),
          PaymentStatusWidget(
            status: _paymentTracker.clientApprovalStatus,
            title: switch (_paymentTracker.clientApprovalStatus) {
              PaymentStepStatus.processing => AppTexts.awaitingClientApproval,
              PaymentStepStatus.completed => AppTexts.clientApprovedContract,
              _ => '',
            },
            description1: switch (_paymentTracker.clientApprovalStatus) {
              PaymentStepStatus.processing => AppTexts.paymentIsLinked,
              PaymentStepStatus.completed => _paymentTracker.paymentConfirmedAt.toFormattedString1(),
              _ => null,
            },
          ),
          PaymentStatusWidget(
            status: _paymentTracker.invoiceCreationStatus,
            title: switch (_paymentTracker.invoiceCreationStatus) {
              PaymentStepStatus.waiting => AppTexts.invoiceCreatedForThisCycle,
              PaymentStepStatus.completed => AppTexts.clientPaymentConfirmed,
              _ => '',
            },
            description1: switch (_paymentTracker.invoiceCreationStatus) {
              PaymentStepStatus.waiting => AppTexts.invoiceCreatedForThisCycleDesc,
              PaymentStepStatus.completed => _paymentTracker.invoiceCreatedAt.toFormattedString1(),
              _ => null,
            },
          ),
          PaymentStatusWidget(
            status: _paymentTracker.paymentConfirmationStatus,
            title: switch (_paymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => '',
              PaymentStepStatus.processing => AppTexts.awaitingPaymentConfirmation,
              PaymentStepStatus.completed => AppTexts.clientPaymentConfirmed,
              PaymentStepStatus.failed => AppTexts.clientPaymentOverdue,
            },
            description1: switch (_paymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => AppTexts.yourClientInvoiceAccess,
              PaymentStepStatus.processing => AppTexts.yourClientInvoiceAccess,
              PaymentStepStatus.completed => _paymentTracker.paymentConfirmedAt.toFormattedString1(),
              PaymentStepStatus.failed => AppTexts.paymentWasExpected,
            },
            description2: switch (_paymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => AppTexts.beforeItIsDue,
              PaymentStepStatus.processing => AppTexts.beforeItIsDue,
              PaymentStepStatus.completed => null,
              PaymentStepStatus.failed => AppTexts.paymentWasExpectedEnding,
            },
            dueDate: switch (_paymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.failed => _paymentTracker.paymentConfirmationDueDate.toFormattedString2(),
              PaymentStepStatus.processing => AppTexts.tenDays,
              PaymentStepStatus.waiting => AppTexts.tenDays,
              PaymentStepStatus.completed => null,
            },
          ),
          PaymentStatusWidget(
            status: _paymentTracker.processPaymentStatus,
            title: switch (_paymentTracker.processPaymentStatus) {
              PaymentStepStatus.waiting => AppTexts.processClientPayment,
              PaymentStepStatus.processing => AppTexts.processingClientPayment,
              PaymentStepStatus.completed => AppTexts.clientPaymentProcessed,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_paymentTracker.processPaymentStatus) {
              PaymentStepStatus.waiting => null,
              PaymentStepStatus.processing => AppTexts.clientWillGetInvoiceAccess,
              PaymentStepStatus.completed => _paymentTracker.paymentProcessedAt.toFormattedString1(),
              PaymentStepStatus.failed => null,
            },
          ),
          PaymentStatusWidget(
            status: _paymentTracker.paymentReceivedStatus,
            title: switch (_paymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.waiting => AppTexts.fundsShouldBeReflected,
              PaymentStepStatus.completed => AppTexts.fundsReceived,
              _ => '',
            },
            dueDate:
                _paymentTracker.paymentReceivedStatus == PaymentStepStatus.waiting ? _paymentTracker.paymentConfirmationDueDate.toFormattedString2() : null,
            description1: switch (_paymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.completed => _paymentTracker.paymentReceivedAt.toFormattedString1(),
              _ => null,
            },
          ),
        ],
      ),
    );
  }
}
