import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/gen/fonts.gen.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance/widget/asset_list_item.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:defifundr_mobile/modules/payment/presentation/payments/screens/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FinanceHomeScreen extends StatelessWidget {
  const FinanceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          centerTitle: false,
          title: 'Finance',
          actions: [],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(context),
              SizedBox(height: 24.h),
              _buildVirtualCardPromo(context),
              SizedBox(height: 24.h),
              _buildAssetsSection(context),
              const SizedBox(height: 24),
              _buildTransactionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total balance',
            style: fonts.textSmSemiBold.copyWith(
              color: colors.textSecondary,
              fontFamily: FontFamily.hankenGrotesk,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$5,050.00',
            style: fonts.heading1Bold.copyWith(
              fontSize: 40.sp,
              fontFamily: FontFamily.hankenGrotesk,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '-0.0051% (\$0.90)',
            style: fonts.textMdMedium.copyWith(
              color: colors.redDefault,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Assets.icons.signIn,
                  label: 'Receive',
                  onPressed: () => context.pushNamed(RouteConstants.receive),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionButton(
                  context: context,
                  icon: Assets.icons.signOut,
                  label: 'Withdraw',
                  onPressed: () => context.pushNamed(RouteConstants.withdraw),
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

  Widget _buildVirtualCardPromo(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 7.0),
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
                SizedBox(
                  width: context.screenWidth(0.5),
                  child: Text(
                    'Spend your crypto anywhere with DefiFundr virtual card.',
                    style: fontTheme.textSmMedium.copyWith(
                      color:
                          isLight ? colors.contrastWhite : colors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                PrimaryButton(
                  onPressed: () {},
                  text: 'Coming soon',
                  color: colors.greenDefault,
                  fixedSize: Size(90.w, 20.h),
                  enableShine: false,
                  borderColor: Colors.transparent,
                  textSize: 10.sp,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 2.sp,
                  ),
                  textColor:
                      isLight ? colors.contrastWhite : colors.textPrimary,
                  borderRadius: BorderRadius.circular(120),
                ),
              ],
            ),
          ),
          Image.asset(
            Assets.images.finance.path,
            fit: BoxFit.cover,
            height: 120.h,
            width: 120.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsSection(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assets',
            style: textTheme.textMdSemiBold.copyWith(
              color: colors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            )),
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
                itemCount: dummyAssets.length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final asset = dummyAssets[index];
                  return AssetListItem(
                    asset: asset,
                    onTap: () => _navigateToAssetDetails(context, asset),
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
            Text('Transactions',
                style: textTheme.textMdSemiBold.copyWith(
                  color: colors.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                )),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(4.sp),
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('See all',
                      style: textTheme.textMdSemiBold.copyWith(
                        color: colors.brandDefault,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  // SizedBox(width: 4.w),
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
            itemCount: _getDummyTransactions(colors).length,
            itemBuilder: (context, index) {
              final payment = _getDummyTransactions(colors)[index];
              return PaymentItemCard(payment: payment);
            },
          ),
        ),
      ],
    );
  }

  void _navigateToAssetDetails(BuildContext context, NetworkAsset asset) {
    final defaultNetwork = Network.supportedNetworks.first;
    context.pushNamed(
      RouteConstants.assetDetails,
      extra: {
        'asset': asset,
        'network': defaultNetwork,
      },
    );
  }

  List<Payment> _getDummyTransactions(AppColorExtension colors) {
    return [
      Payment(
        title: 'LoopLabs Transfer and djdjdjjdjdjdjdjdj',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.invoice,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'MintForge Bug fixes and djdjdjjdjdjdjdjdj',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2025, 5, 21),
        amount: 581,
        paymentNetwork: PaymentNetwork.starknet,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.money,
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
        icon: Assets.icons.invoice,
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
        icon: Assets.icons.money,
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
        icon: Assets.icons.invoice,
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
        icon: Assets.icons.money,
        iconBackgroundColor: colors.brandDefault,
      ),
    ];
  }
}
