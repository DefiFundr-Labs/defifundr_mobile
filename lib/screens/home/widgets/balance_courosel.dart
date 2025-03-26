import 'package:carousel_slider/carousel_slider.dart';
import 'package:defifundr_mobile/screens/home/widgets/balance_card.dart';
import 'package:flutter/material.dart';

class BalanceCardCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> balanceCards;
  final CarouselSliderController carouselController;
  final int currentCardIndex;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const BalanceCardCarousel({
    Key? key,
    required this.balanceCards,
    required this.carouselController,
    required this.currentCardIndex,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: 190,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: onPageChanged,
          ),
          items: balanceCards.map((card) {
            return BalanceCard(card: card, currentCardIndex: currentCardIndex, totalCards: balanceCards.length);
          }).toList(),
        ),
      ],
    );
  }
}