import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ellipsify(word: item.name, maxLength: 21),
                    style: context.theme.fonts.textMdSemiBold),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity} unit(s) at ${item.price.toStringAsFixed(2)} USDT',
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${item.total} USDT',
                  style: context.theme.fonts.textMdSemiBold),
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
