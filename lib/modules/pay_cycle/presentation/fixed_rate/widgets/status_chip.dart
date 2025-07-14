import 'package:flutter/material.dart';

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
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case PaymentStatus.approved:
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        text = 'Approved';
        break;
      case PaymentStatus.pending:
        backgroundColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        text = 'Pending approval';
        break;
      case PaymentStatus.overdue:
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        text = 'Overdue';
        break;
      case PaymentStatus.paid:
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        text = 'Paid';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
