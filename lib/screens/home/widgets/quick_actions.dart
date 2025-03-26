import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/screens/home/widgets/actions_items.dart';
import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: DefiFundrFonts.h3(context)
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ActionItem(
              icon: AppAssets.payslip,
              iconColor: Colors.green,
              backgroundColor: const Color(0xFFE8F5E9),
              title: 'Payslips',
              onTap: () {},
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ActionItem(
                icon: AppAssets.people2,
                iconColor: Colors.indigo,
                backgroundColor: const Color(0xFFE8EAF6),
                title: 'Workspace',
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ActionItem(
                icon: AppAssets.reciept,
                iconColor: Colors.deepOrange,
                backgroundColor: const Color(0xFFFBE9E7),
                title: 'Invoice',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ActionItem(
                icon: AppAssets.money,
                iconColor: Colors.deepPurple,
                backgroundColor: const Color(0xFFEDE7F6),
                title: 'Quickpay',
                borderColor: const Color(0xFF7E57C2),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
