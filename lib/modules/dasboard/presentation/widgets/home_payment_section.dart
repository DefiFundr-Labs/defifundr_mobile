import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_section_header.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:defifundr_mobile/modules/payment/presentation/payments/screens/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePaymentSection extends StatelessWidget {
  final String title;
  final String emptyMessage;
  final List<Payment> payments;
  final bool hasData;
  final Widget Function(BuildContext context, Payment payment)? itemBuilder;
  final VoidCallback? onSeeAll;

  const HomePaymentSection({
    super.key,
    required this.title,
    required this.emptyMessage,
    required this.payments,
    required this.hasData,
    this.itemBuilder,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        HomeSectionHeader(title: title, onSeeAll: onSeeAll),
        SizedBox(height: 8.h),
        hasData
            ? Container(
                decoration: BoxDecoration(
                  color: isLightMode ? colors.bgB0 : colors.bgB1,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: payments.length,
                  itemBuilder: (ctx, index) =>
                      itemBuilder?.call(ctx, payments[index]) ??
                      PaymentItemCard(payment: payments[index]),
                ),
              )
            : HomeEmptyState(
                imagePath: Assets.icons.emptyQuickpayIcon,
                message: emptyMessage,
              ),
      ],
    );
  }
}
