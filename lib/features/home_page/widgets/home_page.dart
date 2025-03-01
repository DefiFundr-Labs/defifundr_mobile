import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
                _buildHeader(),
                const SizedBox(height: 24),
                _buildBalanceCardCarousel(),
                const SizedBox(height: 20),
                _buildProfileCompletion(),
                const SizedBox(height: 24),
                _buildQuickActions(),
                const SizedBox(height: 24),
                _buildContracts(),
                const SizedBox(height: 24),
                _buildRecentPayslip(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Good ${_getGreeting()}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(AppAssets.cloud)
              ],
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF616161),
            size: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCardCarousel() {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 190,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCardIndex = index;
              });
            },
          ),
          items: _balanceCards.map((card) {
            return Builder(
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          left: 160,
                          child: SvgPicture.asset(AppAssets.eclipse)),
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
                                    border:
                                        Border.all(color: AppColors.grey400)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
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
                              children:
                                  List.generate(_balanceCards.length, (index) {
                                return Container(
                                  width: index == _currentCardIndex ? 12 : 5,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    color: index == _currentCardIndex
                                        ? const Color(0xFF9E9E9E)
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
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProfileCompletion() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF9C4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  color: Color(0xFFFBC02D),
                  size: 20,
                ),
              ),
              const SizedBox(width: 21),
              const Text(
                'Complete Profile',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF616161),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: profileCompletionPercentage / 100,
                      strokeWidth: 4,
                      backgroundColor: const Color(0xFFEEEEEE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF3F51B5)),
                    ),
                    Center(
                      child: Text(
                        '$profileCompletionPercentage%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F51B5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionItem(
                icon: Icons.receipt_long,
                iconColor: Colors.green,
                backgroundColor: const Color(0xFFE8F5E9),
                title: 'Payslips',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing Payslips')),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionItem(
                icon: Icons.bubble_chart,
                iconColor: Colors.indigo,
                backgroundColor: const Color(0xFFE8EAF6),
                title: 'Workspace',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening Workspace')),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionItem(
                icon: Icons.receipt_outlined,
                iconColor: Colors.deepOrange,
                backgroundColor: const Color(0xFFFBE9E7),
                title: 'Invoice',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating Invoice')),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionItem(
                icon: Icons.payments_outlined,
                iconColor: Colors.deepPurple,
                backgroundColor: const Color(0xFFEDE7F6),
                title: 'Quickpay',
                hasBorder: true,
                borderColor: const Color(0xFF7E57C2),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Using Quickpay')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required VoidCallback onTap,
    bool hasBorder = false,
    Color borderColor = Colors.transparent,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 62,
        width: 168,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: backgroundColor, shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContracts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contracts',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF2196F3),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Contracts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(child: SvgPicture.asset(AppAssets.noTransaction)),
              const SizedBox(height: 16),
              const Text(
                'Contracts will appear here',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPayslip() {
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

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            String destination = "";
            switch (index) {
              case 0:
                destination = "Home";
                break;
              case 1:
                destination = "Workspace";
                break;
              case 2:
                destination = "Finance";
                break;
              case 3:
                destination = "Profile";
                break;
            }
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color(0xFF212121),
          unselectedItemColor: const Color(0xFF9E9E9E),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.home),
              label: '•',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_filled),
              label: 'Workspace',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.dollarCircle),
              label: 'Finance',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.dollarCircle),
              label: 'More',
            ),
          ],
        ),
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

  String _formatCurrency(double amount) {
    return NumberFormat('#,##0.00', 'en_US').format(amount);
  }
}
