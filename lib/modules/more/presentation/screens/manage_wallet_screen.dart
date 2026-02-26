// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/more/presentation/widgets/wallet_identicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _WalletItem {
  final String address;
  final String shortAddress;
  final String walletType;
  final String balance;

  const _WalletItem({
    required this.address,
    required this.shortAddress,
    required this.walletType,
    required this.balance,
  });
}

@RoutePage()
class ManageWalletScreen extends StatelessWidget {
  const ManageWalletScreen({super.key});

  static const List<_WalletItem> _wallets = [
    _WalletItem(
      address: '0xC524b945DDB20f703338f4696102D10bbC12629C',
      shortAddress: '0xC524...629C',
      walletType: 'EVM wallet',
      balance: r'$0.00',
    ),
    _WalletItem(
      address: '0xCa14007Eed9e7b282A2929B3f5bE7c9A41272766',
      shortAddress: '0xCa14...2766',
      walletType: 'Starknet wallet',
      balance: r'$0.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text(
                'Manage wallet',
                style: fonts.heading2Bold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'View your wallet details and securely access your private key.',
                style: fonts.textBaseRegular.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Wallets',
                style: fonts.textSmMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              ...List.generate(_wallets.length, (index) {
                final wallet = _wallets[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _WalletCard(wallet: wallet),
                );
              }),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final _WalletItem wallet;

  const _WalletCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return InkWell(
      onTap: () {
        context.router.push(
          WalletDetailRoute(
            walletAddress: wallet.address,
            shortAddress: wallet.shortAddress,
            walletType: wallet.walletType,
            balance: wallet.balance,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isLightMode ? colors.bgB0 : colors.bgB1,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            WalletIdenticon(
              address: wallet.address,
              size: 48.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        wallet.shortAddress,
                        style: fonts.textBaseSemiBold.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: isLightMode ? colors.bgB1 : colors.bgB2,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          wallet.walletType,
                          style: fonts.textXsRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: r'$0',
                          style: fonts.textBaseSemiBold.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: '.00',
                          style: fonts.textBaseSemiBold.copyWith(
                            color: colors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textTertiary,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
