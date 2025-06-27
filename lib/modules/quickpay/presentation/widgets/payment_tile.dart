import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PaymentTile extends StatelessWidget {
  final List<QuickPayment> payments;

  const PaymentTile(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.theme.colors.bgB1,
          boxShadow: [
            BoxShadow(
                color: context.theme.colors.contrastBlack,
                spreadRadius: -5,
                offset: Offset(0, 1),
                blurRadius: 1)
          ]),
      child: Column(
        children: payments.map((payment) {
          return Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(
                  RouteConstants.transactionScreen,
                  extra: payment,
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.depositIconSvg),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(payment.description,
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.textPrimary,
                            )),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('h:mm a').format(payment.date),
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '${payment.paymentType == QuickPaymentsType.deposit ? '+' : '-'}${payment.amount} ${payment.currency}',
                          style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.textPrimary)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: payment.status.textColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(payment.status.titleCase,
                              style: context.theme.fonts.textSmMedium.copyWith(
                                color: payment.status.textColor(context),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
