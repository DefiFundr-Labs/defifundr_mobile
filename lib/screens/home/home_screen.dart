import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/home/widgets/balance_courosel.dart';
import 'package:defifundr_mobile/screens/home/widgets/bottom_navigation.dart';
import 'package:defifundr_mobile/screens/home/widgets/contract_section.dart';
import 'package:defifundr_mobile/screens/home/widgets/home_header.dart';
import 'package:defifundr_mobile/screens/home/widgets/profile_completeion_card.dart';
import 'package:defifundr_mobile/screens/home/widgets/quick_actions.dart';
import 'package:defifundr_mobile/screens/home/widgets/recent_playsip_section.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final String userName = 'Ademola';
  final double balance = 62231.57;
  final int profileCompletionPercentage = 45;

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentCardIndex = 0;
  final List<Map<String, dynamic>> _balanceCards = [
    {
      'type': 'NGN Balance',
      'icon': 'assets/tether.png',
      'balance': 62231.57,
      'currency': '₦',
    },
    {
      'type': 'USDT Balance',
      'icon': 'assets/tether.png',
      'balance': 62231.57,
      'currency': '₮',
    },
    {
      'type': 'USDC Balance',
      'icon': 'assets/tether.png',
      'balance': 62231.57,
      'currency': '\$',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Header(
                  userName: userName,
                  greeting: _getGreeting(),
                ),
                const SizedBox(height: 24),
                BalanceCardCarousel(
                  balanceCards: _balanceCards,
                  carouselController: _carouselController,
                  currentCardIndex: _currentCardIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCardIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ProfileCompletionCard(
                  percentage: profileCompletionPercentage,
                ),
                const SizedBox(height: 24),
                const QuickActions(),
                const SizedBox(height: 24),
                const ContractsSection(),
                const SizedBox(height: 24),
                const RecentPayslipSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
