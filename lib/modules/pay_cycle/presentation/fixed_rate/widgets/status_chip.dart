import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';

import '../../../data/models/contract.dart';

class StatusChip extends StatelessWidget {
  final PaymentStatus status;
  final double? fontSize;

  const StatusChip({
    Key? key,
    required this.status,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: config.borderColor),
      ),
      child: Text(
        config.text,
        style: context.theme.fonts.textSmMedium.copyWith(
          color: config.textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(PaymentStatus status, BuildContext context) {
    switch (status) {
      case PaymentStatus.approved:
      case PaymentStatus.paid:
        return _StatusConfig(
          backgroundColor: context.theme.colors.greenFill,
          textColor: context.theme.colors.greenDefault,
          borderColor: context.theme.colors.greenStroke,
          text: status == PaymentStatus.approved ? 'Approved' : 'Paid',
        );
      case PaymentStatus.pending:
        return _StatusConfig(
          backgroundColor: context.theme.colors.orangeFill,
          textColor: context.theme.colors.orangeDefault,
          borderColor: context.theme.colors.orangeStroke,
          text: 'Pending approval',
        );
      case PaymentStatus.overdue:
        return _StatusConfig(
          backgroundColor: context.theme.colors.redFill,
          textColor: context.theme.colors.redDefault,
          borderColor: context.theme.colors.redStroke,
          text: 'Overdue',
        );
      case PaymentStatus.pendingApproval:
        return _StatusConfig(
          backgroundColor: context.theme.colors.orangeFill,
          textColor: context.theme.colors.orangeDefault,
          borderColor: context.theme.colors.orangeStroke,
          text: 'Pending approval',
        );
      case PaymentStatus.pendingSubmission:
        return _StatusConfig(
          backgroundColor: context.theme.colors.orangeFill,
          textColor: context.theme.colors.orangeDefault,
          borderColor: context.theme.colors.orangeStroke,
          text: 'Pending submission',
        );
      case PaymentStatus.awaitingPayment:
        return _StatusConfig(
          backgroundColor: context.theme.colors.brandFill,
          textColor: context.theme.colors.brandDefault,
          borderColor: context.theme.colors.brandStroke,
          text: 'Awaiting payment',
        );
      case PaymentStatus.rejected:
        return _StatusConfig(
          backgroundColor: context.theme.colors.redFill,
          textColor: context.theme.colors.redDefault,
          borderColor: context.theme.colors.redStroke,
          text: 'Rejected',
        );
    }
  }
}

class _StatusConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final String text;

  const _StatusConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.text,
  });
}
