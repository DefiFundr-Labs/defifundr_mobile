import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback? onTap;

  const InvoiceCard({
    Key? key,
    required this.invoice,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${invoice.id}",
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(invoice.title, style: context.theme.fonts.textMdSemiBold),
            SizedBox(height: 4.h),
            Text(
              invoice.client,
              style: context.theme.fonts.textSmRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice.amount,
                        style: context.theme.fonts.textMdSemiBold),
                    const SizedBox(height: 4),
                    Text(
                      'Issue Date: ${invoice.issueDate}',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                InvoiceStatusChip(status: invoice.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
