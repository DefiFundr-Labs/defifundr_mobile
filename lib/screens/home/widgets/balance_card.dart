import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final Map<String, dynamic> card;
  final int currentCardIndex;
  final int totalCards;

  const BalanceCard({
    Key? key,
    required this.card,
    required this.currentCardIndex,
    required this.totalCards,
  }) : super(key: key);

  String _formatCurrency(double amount) {
    return NumberFormat('#,##0.00', 'en_US').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          width: 348,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  left: 160, child: SvgPicture.asset(AppAssets.eclipse)),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 26,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: AppColors.grey400)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.tether),
                              const SizedBox(width: 3),
                              Text(
                                card['type'],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${card['currency']}${_formatCurrency(card['balance'])}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7E57C2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'View Breakdown',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7E57C2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalCards, (index) {
                        return Container(
                          width: index == currentCardIndex ? 12 : 5,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: index == currentCardIndex
                                ? AppColors.purple505
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
