import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentPayslipSection extends StatelessWidget {
  const RecentPayslipSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Payslip',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing all payslips')),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.grey100,
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(child: SvgPicture.asset(AppAssets.transaction)),
      ],
    );
  }
}
