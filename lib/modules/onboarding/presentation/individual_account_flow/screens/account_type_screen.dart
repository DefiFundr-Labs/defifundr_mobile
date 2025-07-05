// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/widgets/account_badge_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          isBack: true,
          title: '',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 4,
              width: double.infinity,
              color: Colors.grey[200],
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColorDark.activeButtonDark,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Account Type',
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: context.theme.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Choose whether you're registering as a freelancer, contractor or a business entity.",
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    AccountTypeCard(
                      icon: Assets.icons.userCircleSvg_,
                      title: 'Freelancer account',
                      description:
                          'You work independently, manage your own contracts and payments directly with clients.',
                      onTap: () {
                        context.pushNamed(RouteConstants.personalDetails);
                      },
                    ),
                    SizedBox(height: 10.h),
                    AccountTypeCard(
                      icon: Assets.icons.briefCase,
                      title: 'Contractor account',
                      description:
                          'You\'re contracted to work for a company or organization on specific projects or terms.',
                      onTap: () {
                        context.pushNamed(RouteConstants.personalDetails);
                      },
                    ),
                    SizedBox(height: 10.h),
                    AccountTypeCard(
                      icon: Assets.icons.buildingOfficeSvg,
                      title: 'Business/Corporate account',
                      description:
                          'You represent a business that manages contracts on behalf of multiple team members.',
                      badge: 'Coming soon',
                      isEnabled: false,
                      onTap: () {
                        // Handle business account selection (disabled for now)
                        print('Business account - Coming soon');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
