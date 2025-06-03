import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/date_time_extension.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:defifundr_mobile/feature/transaction/models/payment_tracker.dart';
import 'package:defifundr_mobile/feature/transaction/widgets/payment_status_widget.dart';
import 'package:flutter/material.dart';

part 'fixed_contract_payment_tracker_widget.dart';
part 'invoice_payment_tracker_widget.dart';
part 'milestone_contract_payment_tracker_widget.dart';
part 'pay_as_you_go_contract_payment_tracker_widget.dart';

class PaymentTrackerWidget extends StatelessWidget {
  final PaymentTracker _paymentTracker;
  const PaymentTrackerWidget(this._paymentTracker, {super.key});

  @override
  Widget build(BuildContext context) {
    return switch (_paymentTracker) {
      InvoicePaymentTracker() => InvoicePaymentTrackerWidget(_paymentTracker as InvoicePaymentTracker),
      FixedContractPaymentTracker() => FixedContractPaymentTrackerWidget(_paymentTracker as FixedContractPaymentTracker),
      PayAsYouGoContractPaymentTracker() => PayAsYouGoContractPaymentTrackerWidget(_paymentTracker as PayAsYouGoContractPaymentTracker),
      MilestoneContractPaymentTracker() => MilestoneContractPaymentTrackerWidget(_paymentTracker as MilestoneContractPaymentTracker),
    };
  }
}
