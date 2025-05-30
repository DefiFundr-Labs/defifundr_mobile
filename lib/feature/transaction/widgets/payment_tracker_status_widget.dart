import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentTrackerStatusWidget extends StatelessWidget {
  final PaymentStepStatus _status;
  const PaymentTrackerStatusWidget(this._status, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      switch (_status) {
        PaymentStepStatus.waiting => AppAssets.waitingStatusIcon,
        PaymentStepStatus.processing => AppAssets.processingStatusIcon,
        PaymentStepStatus.completed => AppAssets.completedStatusIcon,
        PaymentStepStatus.failed => AppAssets.failedStatusIcon,
      },
      width: 20,
      height: 20,
    );
  }
}
