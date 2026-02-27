import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

@RoutePage()
class WithdrawPreviewScreen extends StatelessWidget {
  final WithdrawDetailsModel? withdrawDetails;

  const WithdrawPreviewScreen({
    super.key,
    this.withdrawDetails,
  });

  static const double _containerPadding = 16.0;
  static const double _verticalSpacing = 16.0;
  static const double _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        final details = withdrawDetails ?? state.withdrawDetails;

        if (details == null) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(context.screenWidth(), 60),
              child: DeFiRaiseAppBar(
                isBack: true,
                title: context.l10n.preview,
                actions: [],
              ),
            ),
            body: Center(
              child: Text(
                'Error: Withdraw details not found',
                style: fontTheme.textBaseMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.screenWidth(), 60),
            child: DeFiRaiseAppBar(
              isBack: true,
              title: context.l10n.preview,
              actions: [],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(_containerPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildAmountCard(details, colors, fontTheme, context),
                        const SizedBox(height: _verticalSpacing),
                        _buildDetailsCard(details, colors, fontTheme, context),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(_containerPadding, 8,
                      _containerPadding, _containerPadding),
                  child:
                      _buildConfirmButton(context, details, colors, fontTheme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmountCard(
    WithdrawDetailsModel details,
    AppColorExtension colors,
    AppFontThemeExtension fontTheme,
    BuildContext context,
  ) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: _containerPadding, vertical: 32.0),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            details.assetIconPath,
            width: 60.w,
            height: 60.h,
          ),
          SizedBox(height: 16.h),
          Text(
            '${_formatAmount(details.amount)} ${details.assetName}',
            style: fontTheme.heading1Bold.copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '≈ \$${_calculateUSDValue(details.amount)}',
            style: fontTheme.textBaseRegular.copyWith(
              color: colors.textSecondary,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
    WithdrawDetailsModel details,
    AppColorExtension colors,
    AppFontThemeExtension fontTheme,
    BuildContext context,
  ) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context.l10n.to,
            _formatAddress(details.recipientAddress),
            colors,
            fontTheme,
          ),
          SizedBox(height: 24.h),
          _buildDetailRowWithIcon(
            context.l10n.network,
            details.networkName,
            details.networkIconPath,
            colors,
            fontTheme,
          ),
          SizedBox(height: 24.h),
          _buildDetailRow(
            context.l10n.fee,
            '${details.fee} ${details.feeCurrency} (≈ \$${_calculateFeeUSD(details.fee)})',
            colors,
            fontTheme,
          ),
          if (details.memo.isNotEmpty == true) ...[
            SizedBox(height: 24.h),
            _buildDetailRow(
              context.l10n.memo,
              details.memo,
              colors,
              fontTheme,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    AppColorExtension colors,
    AppFontThemeExtension fontTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: fontTheme.textMdRegular.copyWith(
            color: colors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: fontTheme.textMdMedium.copyWith(
              color: colors.textPrimary,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithIcon(
    String label,
    String value,
    String iconPath,
    AppColorExtension colors,
    AppFontThemeExtension fontTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: fontTheme.textMdRegular.copyWith(
            color: colors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 8.w),
            Text(
              value,
              style: fontTheme.textMdMedium.copyWith(
                color: colors.textPrimary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    WithdrawDetailsModel details,
    AppColorExtension colors,
    AppFontThemeExtension fontTheme,
  ) {
    return PrimaryButton(
      text: context.l10n.confirm,
      onPressed: () {
        _onConfirm(context, details);
      },
    );
  }

  void _onConfirm(BuildContext context, WithdrawDetailsModel details) {
    context.router.push(
      ConfirmPaymentRoute(withdrawDetails: details),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.toInt()) {
      return amount.toInt().toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
    }

    String formatted = amount.toStringAsFixed(7);

    formatted =
        formatted.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

    List<String> parts = formatted.split('.');
    if (parts[0].isNotEmpty) {
      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    }

    return parts.join('.');
  }

  String _formatAddress(String address) {
    if (address.length <= 24) {
      return address;
    }
    return '${address.substring(0, 9)}...${address.substring(address.length - 8)}';
  }

  String _calculateUSDValue(double amount) {
    const double exchangeRate = 1.0;
    return (amount * exchangeRate).toStringAsFixed(2);
  }

  String _calculateFeeUSD(double fee) {
    const double exchangeRate = 1.0;
    return (fee * exchangeRate).toStringAsFixed(2);
  }
}
