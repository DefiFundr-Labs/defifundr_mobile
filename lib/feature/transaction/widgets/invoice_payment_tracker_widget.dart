import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/date_time_extension.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:defifundr_mobile/feature/transaction/models/invoice_payment_tracker.dart';
import 'package:flutter/material.dart';

import 'payment_status_widget.dart';

class InvoicePaymentTrackerWidget extends StatelessWidget {
  final InvoicePaymentTracker _invoicePaymentTracker;
  const InvoicePaymentTrackerWidget(this._invoicePaymentTracker, {super.key});

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
            title: AppTexts.invoiceCreatedAndSent,
            description1: _invoicePaymentTracker.createdAt.toFormattedString1(),
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
              PaymentStepStatus.waiting => '',
              PaymentStepStatus.processing => AppTexts.clientWillGetInvoiceAccess,
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentConfirmedAt.toFormattedString1(),
              PaymentStepStatus.failed => AppTexts.paymentWasExpected,
            },
            dueDate: _invoicePaymentTracker.paymentConfirmationDueDate,
            description2: switch (_invoicePaymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => '.',
              PaymentStepStatus.processing => '.',
              PaymentStepStatus.completed => null,
              PaymentStepStatus.failed => AppTexts.paymentWasExpectedEnding,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.paymentProcessingStatus,
            title: switch (_invoicePaymentTracker.paymentProcessingStatus) {
              PaymentStepStatus.waiting => AppTexts.processClientPayment,
              PaymentStepStatus.processing => AppTexts.processingClientPayment,
              PaymentStepStatus.completed => AppTexts.clientPaymentProcessed,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_invoicePaymentTracker.paymentProcessingStatus) {
              PaymentStepStatus.waiting => null,
              PaymentStepStatus.processing => AppTexts.clientWillGetInvoiceAccess,
              PaymentStepStatus.completed => _invoicePaymentTracker.paymentProcessedAt.toFormattedString1(),
              PaymentStepStatus.failed => null,
            },
          ),
          PaymentStatusWidget(
            status: _invoicePaymentTracker.paymentReceivedStatus,
            isLastStep: true,
            title: switch (_invoicePaymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.waiting => AppTexts.fundsShouldBeReflected,
              PaymentStepStatus.processing => '',
              PaymentStepStatus.completed => '',
              PaymentStepStatus.failed => '',
            },
            description1: switch (_invoicePaymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.waiting => null,
              PaymentStepStatus.processing => null,
              PaymentStepStatus.completed => null,
              PaymentStepStatus.failed => null,
            },
            dueDate: _invoicePaymentTracker.paymentReceivedStatus == PaymentStepStatus.waiting ? _invoicePaymentTracker.paymentConfirmationDueDate : null,
          ),
        ],
      ),
    );
  }
}
