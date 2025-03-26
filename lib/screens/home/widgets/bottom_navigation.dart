// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          currentIndex: selectedIndex,
          onTap: onTap,
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
              icon: SvgPicture.asset(AppAssets.people4),
              label: 'Workspace',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.dollarCircle),
              label: 'Finance',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssets.profileImage),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
