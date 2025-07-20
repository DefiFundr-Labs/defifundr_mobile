import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceStatusChip extends StatelessWidget {
  final InvoiceStatus status;

  const InvoiceStatusChip({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: config.borderColor),
      ),
      child: Text(
        config.text,
        style: context.theme.fonts.textMdRegular.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
          color: config.textColor,
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(InvoiceStatus status, BuildContext context) {
    switch (status) {
      case InvoiceStatus.pending:
        return _StatusConfig(
          backgroundColor: context.theme.colors.orangeFill,
          textColor: context.theme.colors.orangeDefault,
          borderColor: context.theme.colors.orangeStroke,
          text: 'Pending',
        );
      case InvoiceStatus.paid:
        return _StatusConfig(
          backgroundColor: context.theme.colors.greenFill,
          textColor: context.theme.colors.greenDefault,
          borderColor: context.theme.colors.greenStroke,
          text: 'Paid',
        );
      case InvoiceStatus.overdue:
        return _StatusConfig(
          backgroundColor: context.theme.colors.redFill,
          textColor: context.theme.colors.redDefault,
          borderColor: context.theme.colors.redStroke,
          text: 'Overdue',
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
