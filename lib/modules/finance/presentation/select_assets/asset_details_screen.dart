import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/gen/fonts.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance/widget/asset_list_item.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:defifundr_mobile/modules/payment/presentation/payments/screens/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AssetDetailsScreen extends StatelessWidget {
  final NetworkAsset asset;
  final Network network;

  const AssetDetailsScreen({
    super.key,
    required this.asset,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          title: asset.name,
          isBack: true,
          actions: [],
          textStyle: context.theme.fonts.heading3SemiBold.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAssetBalanceCard(context),
              SizedBox(height: 24.h),
              _buildMyAssetSection(context),
              SizedBox(height: 24.h),
              _buildTransactionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetBalanceCard(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 24.sp),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Asset Icon
          CircleAvatar(
            radius: 24.sp,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              asset.iconPath,
              width: 52.sp,
              height: 52.sp,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.currency_bitcoin,
                color: colors.textPrimary,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Asset Balance
          Text(
            asset.balanceCurrency,
            style: fonts.heading1Bold.copyWith(
              fontSize: 32.sp,
              fontFamily: FontFamily.hankenGrotesk,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          // USD Value
          Text(
            '≈ ${asset.balance}',
            style: fonts.textMdMedium.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Assets.icons.signIn,
                  label: 'Receive',
                  onPressed: () => context.router.push(const ReceiveRoute()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Assets.icons.signOut,
                  label: 'Withdraw',
                  onPressed: () => context.router.push(const WithdrawRoute()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        icon,
        height: 20,
        width: 20,
        colorFilter: ColorFilter.mode(
          isLight ? colors.brandDefault : colors.textPrimary,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: fonts.textMdMedium.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isLight ? colors.brandDefault : colors.textPrimary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isLight ? colors.brandFill : colors.bgB2,
        foregroundColor: colors.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildMyAssetSection(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My ${asset.name}',
          style: textTheme.textMdSemiBold.copyWith(
            color: colors.textPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: isLightMode ? colors.bgB0 : colors.bgB1,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _getRelatedAssets().length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final relatedAsset = _getRelatedAssets()[index];
                  return AssetListItem(
                    asset: relatedAsset,
                    onTap: () => _navigateToAssetDetails(context, relatedAsset),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Transactions',
              style: textTheme.textMdSemiBold.copyWith(
                color: colors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full transactions list
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(4.sp),
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'See all',
                    style: textTheme.textMdSemiBold.copyWith(
                      color: colors.brandDefault,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.icons.caretRightSvg,
                    height: 13.h,
                    width: 12.w,
                    colorFilter: ColorFilter.mode(
                      colors.brandDefault,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: isLightMode ? colors.bgB0 : colors.bgB1,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _getAssetTransactions(context).length,
            itemBuilder: (context, index) {
              final payment = _getAssetTransactions(context)[index];
              return PaymentItemCard(payment: payment);
            },
          ),
        ),
      ],
    );
  }

  void _navigateToAssetDetails(BuildContext context, NetworkAsset asset) {
    final defaultNetwork = Network.supportedNetworks.first;
    context.router.push(
      AssetDetailsRoute(
        asset: asset,
        network: defaultNetwork,
      ),
    );
  }

  List<NetworkAsset> _getRelatedAssets() {
    // Return assets related to the current asset (same currency on different networks)
    return [
      NetworkAsset(
        iconPath: asset.iconPath,
        name: asset.name,
        price: asset.price,
        change: asset.change,
        balance: '\$476.19',
        balanceCurrency: '476 ${asset.name}',
        network: Network.supportedNetworks.firstWhere(
          (net) => net.name == 'Ethereum',
          orElse: () => Network.supportedNetworks.first,
        ),
      ),
      NetworkAsset(
        iconPath: asset.iconPath,
        name: asset.name,
        price: asset.price,
        change: asset.change,
        balance: '\$200.19',
        balanceCurrency: '200 ${asset.name}',
        network: Network.supportedNetworks.firstWhere(
          (net) => net.name == 'Optimism',
          orElse: () => Network.supportedNetworks.first,
        ),
      ),
    ];
  }

  List<Payment> _getAssetTransactions(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;

    return [
      Payment(
        title: 'Withdrawal',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: asset.name,
        status: PaymentStatus.overdue,
        icon: Assets.icons.money,
        iconBackgroundColor: colors.brandDefault,
      ),
      Payment(
        title: 'Received from wallet',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 5, 20),
        amount: 1000,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: asset.name,
        status: PaymentStatus.upcoming,
        icon: Assets.icons.invoice,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'DeFi Staking Reward',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 19),
        amount: 25,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: asset.name,
        status: PaymentStatus.upcoming,
        icon: Assets.icons.money,
        iconBackgroundColor: colors.greenDefault,
      ),
    ];
  }
}
