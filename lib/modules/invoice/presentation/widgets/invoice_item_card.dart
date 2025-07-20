import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InvoiceItemCard extends StatelessWidget {
  final InvoiceItem item;
  final VoidCallback? onEdit;

  const InvoiceItemCard({
    Key? key,
    required this.item,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colors.strokeSecondary),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity} unit(s) at ${item.price.toStringAsFixed(2)} USDT',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontSize: 12.sp,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${item.total} USDT',
                style: context.theme.fonts.textMdSemiBold.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  Assets.icons.notePencil,
                  width: 20.w,
                  height: 20.h,
                  color: context.theme.colors.graySecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
