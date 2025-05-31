import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/date_time_extension.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:defifundr_mobile/feature/transaction/models/fixed_contract_payment_tracker.dart';
import 'package:defifundr_mobile/feature/transaction/widgets/payment_status_widget.dart';
import 'package:flutter/material.dart';

class FixedContractPaymentTrackerWidget extends StatelessWidget {
  final FixedContractPaymentTracker _invoicePaymentTracker;
  const FixedContractPaymentTrackerWidget(this._invoicePaymentTracker, {super.key});

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
            description1: _invoicePaymentTracker.createdAt.toFormattedString1(),
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.clientApprovalStatus,
            title: switch (_invoicePaymentTracker.clientApprovalStatus) {
              PaymentStepStatus.waiting => '',
              PaymentStepStatus.processing => AppTexts.awaitingClientApproval,
              PaymentStepStatus.completed => AppTexts.clientPaymentConfirmed,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_invoicePaymentTracker.clientApprovalStatus) {
              PaymentStepStatus.waiting => null,
              PaymentStepStatus.processing => AppTexts.paymentIsLinked,
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentConfirmedAt.toFormattedString1(),
              PaymentStepStatus.failed => null,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.invoiceCreationStatus,
            title: switch (_invoicePaymentTracker.invoiceCreationStatus) {
              PaymentStepStatus.waiting => AppTexts.invoiceCreatedForThisCycle,
              PaymentStepStatus.processing => '',
              PaymentStepStatus.completed => AppTexts.clientPaymentConfirmed,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_invoicePaymentTracker.invoiceCreationStatus) {
              PaymentStepStatus.waiting => AppTexts.invoiceCreatedForThisCycleDesc,
              PaymentStepStatus.processing => null,
              PaymentStepStatus.completed => _invoicePaymentTracker.invoiceCreatedAt.toFormattedString1(),
              PaymentStepStatus.failed => null,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.paymentConfirmationStatus,
            title: switch (_invoicePaymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => '',
              PaymentStepStatus.processing => AppTexts.awaitingPaymentConfirmation,
              PaymentStepStatus.completed => AppTexts.clientPaymentConfirmed,
              PaymentStepStatus.failed => AppTexts.clientPaymentOverdue,
            },
            description1: switch (_invoicePaymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => AppTexts.yourClientInvoiceAccess,
              PaymentStepStatus.processing => AppTexts.yourClientInvoiceAccess,
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentConfirmedAt.toFormattedString1(),
              PaymentStepStatus.failed => AppTexts.paymentWasExpected,
            },
            description2: switch (_invoicePaymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => AppTexts.beforeItIsDue,
              PaymentStepStatus.processing => AppTexts.beforeItIsDue,
              PaymentStepStatus.completed => null,
              PaymentStepStatus.failed => AppTexts.paymentWasExpectedEnding,
            },
            dueDate: switch (_invoicePaymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.failed => _invoicePaymentTracker.paymentConfirmationDueDate.toFormattedString2(),
              PaymentStepStatus.processing => AppTexts.tenDays,
              PaymentStepStatus.waiting => AppTexts.tenDays,
              PaymentStepStatus.completed => null,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.processPaymentStatus,
            title: switch (_invoicePaymentTracker.processPaymentStatus) {
              PaymentStepStatus.waiting => AppTexts.processClientPayment,
              PaymentStepStatus.processing => AppTexts.processingClientPayment,
              PaymentStepStatus.completed => AppTexts.clientPaymentProcessed,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_invoicePaymentTracker.processPaymentStatus) {
              PaymentStepStatus.waiting => null,
              PaymentStepStatus.processing => AppTexts.clientWillGetInvoiceAccess,
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentProcessedAt.toFormattedString1(),
              PaymentStepStatus.failed => null,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.paymentReceivedStatus,
            title: switch (_invoicePaymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.waiting => AppTexts.fundsShouldBeReflected,
              PaymentStepStatus.completed => AppTexts.fundsReceived,
              _ => '',
            },
            dueDate: _invoicePaymentTracker.paymentReceivedStatus == PaymentStepStatus.waiting
                ? _invoicePaymentTracker.paymentConfirmationDueDate.toFormattedString2()
                : null,
            description1: switch (_invoicePaymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentReceivedAt.toFormattedString1(),
              _ => null,
            },
          ),
        ],
      ),
    );
  }
}
