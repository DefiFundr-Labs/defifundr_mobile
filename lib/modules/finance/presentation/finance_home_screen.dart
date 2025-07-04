import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_network_screen.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:defifundr_mobile/modules/payment/presentation/payments/screens/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Asset {
  final String iconPath;
  final String name;
  final String price;
  final String change;
  final String balance;
  final String balanceCurrency;
  final Network? network;

  Asset({
    required this.iconPath,
    required this.name,
    required this.price,
    required this.change,
    required this.balance,
    required this.balanceCurrency,
    this.network,
  });
}

class AssetListItem extends StatelessWidget {
  final Asset asset;
  final VoidCallback? onTap;

  const AssetListItem({Key? key, required this.asset, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  asset.iconPath,
                  width: 36,
                  height: 36,
                ),
                if (asset.network != null)
                  Positioned(
                    bottom: -6,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        asset.network!.iconPath,
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: fontTheme.textBaseSemiBold,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        asset.price,
                        style: fontTheme.textSmRegular,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        asset.change,
                        style: fontTheme.textSmRegular
                            .copyWith(color: colors.redDefault),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  asset.balance,
                  style: fontTheme.textBaseSemiBold,
                ),
                const SizedBox(height: 4),
                Text(
                  asset.balanceCurrency,
                  style: fontTheme.textSmRegular
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FinanceHomeScreen extends StatelessWidget {
  const FinanceHomeScreen({Key? key}) : super(key: key);

  static final List<Asset> dummyAssets = [
    Asset(
      iconPath: 'assets/images/usdt.png',
      name: 'Tether USD',
      price: '\$1.00',
      change: '-0.0018%',
      balance: '\$476.19',
      balanceCurrency: '581 USDT',
    ),
    Asset(
      iconPath: 'assets/images/usdc.png',
      name: 'USD Coin',
      price: '\$0.99',
      change: '-0.005%',
      balance: '\$381.19',
      balanceCurrency: '381 USDC',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;
    final textTheme = context.theme.textTheme;

    final List<Payment> dummyTransactions = [
      Payment(
        title: 'LoopLabs Transfer fo...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: 'assets/images/invoice.png',
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'MintForge Bug fixes a...',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.starknet,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: 'assets/images/money.png',
        iconBackgroundColor: colors.brandDefault,
      ),
      Payment(
        title: 'ShopLink Pro UX Audi...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.solana,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: 'assets/images/invoice.png',
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'Brightfolk Payment fo...',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.overdue,
        icon: 'assets/images/money.png',
        iconBackgroundColor: colors.brandDefault,
      ),
      Payment(
        title: 'Neurolytix Initial cons...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.starknet,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: 'assets/images/invoice.png',
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'Quikdash Reimburse...',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.solana,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: 'assets/images/money.png',
        iconBackgroundColor: colors.brandDefault,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: false,
          title: 'Finance',
          actions: [],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total balance',
                      style: textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$5,050.00',
                      style: textTheme.headlineLarge?.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '-0.0051% (\$0.90)',
                      style: textTheme.bodySmall?.copyWith(
                          color: colors.redDefault,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.pushNamed(RouteConstants.receive);
                            },
                            icon: SvgPicture.asset('assets/icons/signIn.svg',
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  BlendMode.srcIn,
                                )),
                            label: Text(
                              'Receive',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? colors.blueDefault
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.brandFill
                                  : colors.bgB2,
                              foregroundColor: colors.textPrimary,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.pushNamed(RouteConstants.withdraw);
                            },
                            icon: SvgPicture.asset('assets/icons/signOut.svg',
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  BlendMode.srcIn,
                                )),
                            label: Text(
                              'Withdraw',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? colors.blueDefault
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.brandFill
                                  : colors.bgB2,
                              foregroundColor: colors.textPrimary,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: colors.brandDefault,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'A virtual card built for your crypto life',
                            style: fontTheme.textBaseBold.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.textWhite
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'launching soon on DefiFundr.',
                            style: fontTheme.textSmRegular.copyWith(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? colors.textWhite.withOpacity(0.8)
                                    : Colors.white),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.greenDefault,
                              foregroundColor: colors.textWhite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Coming soon',
                              style: fontTheme.textSmSemiBold
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/finance.png',
                      height: 120,
                      width: 120,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Assets', style: textTheme.displayMedium),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                    color: colors.bgB1,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dummyAssets.length,
                      itemBuilder: (context, index) {
                        final asset = dummyAssets[index];
                        return AssetListItem(
                          asset: asset,
                          onTap: () {
                            final defaultNetwork =
                                SelectNetworkScreen.dummyNetworks.first;
                            context.pushNamed(
                              RouteConstants.assetDetails,
                              extra: {
                                'asset': asset,
                                'network': defaultNetwork,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: textTheme.displayMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all >',
                        style: fontTheme.textBaseMedium
                            .copyWith(color: colors.brandDefault)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colors.bgB1),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dummyTransactions.length,
                  itemBuilder: (context, index) {
                    final payment = dummyTransactions[index];
                    return PaymentItemCard(payment: payment);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
