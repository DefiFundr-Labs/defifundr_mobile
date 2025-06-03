part of 'payment_tracker_widget.dart';

class InvoicePaymentTrackerWidget extends StatelessWidget {
  final InvoicePaymentTracker _paymentTracker;
  const InvoicePaymentTrackerWidget(this._paymentTracker, {super.key});

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
            description1: _paymentTracker.createdAt.toFormattedString1(),
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
              PaymentStepStatus.waiting => '',
              PaymentStepStatus.processing => AppTexts.clientWillGetInvoiceAccess,
              PaymentStepStatus.completed => _paymentTracker.paymentConfirmedAt.toFormattedString1(),
              PaymentStepStatus.failed => AppTexts.paymentWasExpected,
            },
            dueDate: _paymentTracker.paymentConfirmationDueDate.toFormattedString2(),
            description2: switch (_paymentTracker.paymentConfirmationStatus) {
              PaymentStepStatus.waiting => '.',
              PaymentStepStatus.processing => '.',
              PaymentStepStatus.completed => null,
              PaymentStepStatus.failed => AppTexts.paymentWasExpectedEnding,
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
            isLastStep: true,
            title: switch (_paymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.waiting => AppTexts.fundsShouldBeReflected,
              PaymentStepStatus.processing => '',
              PaymentStepStatus.completed => AppTexts.fundsReceived,
              PaymentStepStatus.failed => '',
            },
            description1: switch (_paymentTracker.paymentReceivedStatus) {
              PaymentStepStatus.completed => _paymentTracker.paymentReceivedAt.toFormattedString1(),
              _ => null,
            },
            dueDate:
                _paymentTracker.paymentReceivedStatus == PaymentStepStatus.waiting ? _paymentTracker.paymentConfirmationDueDate.toFormattedString2() : null,
          ),
        ],
      ),
    );
  }
}
