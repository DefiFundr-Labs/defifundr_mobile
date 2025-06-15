import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw_details_model.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/shared/user_interface/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/presentation/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawPreviewScreen extends StatelessWidget {
  final WithdrawDetailsModel? withdrawDetails;

  const WithdrawPreviewScreen({
    Key? key,
    this.withdrawDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        // Use withdraw details from constructor if available, otherwise from bloc state
        final details = withdrawDetails ?? state.withdrawDetails;

        if (details == null) {
          return Scaffold(
            body: Center(
              child: Text('Error: Withdraw details not found'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: colors.bgB0,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                DeFiRaiseAppBar(
                  title: 'Preview',
                  isBack: true,
                ),
                SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  color: colors.bgB1,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          details.assetIconPath,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          '${details.amount} ${details.assetName}',
                          style: fontTheme.heading2Bold,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '≈ \$5.19',
                          style: fontTheme.textBaseRegular
                              ?.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  margin: EdgeInsets.zero,
                  color: colors.bgB1,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('To',
                                style: fontTheme.textSmRegular
                                    ?.copyWith(color: colors.textSecondary)),
                            Text(
                              details.recipientAddress.length > 24
                                  ? details.recipientAddress.substring(0, 24) +
                                      '...'
                                  : details.recipientAddress,
                              style: fontTheme.textBaseMedium
                                  ?.copyWith(color: colors.textPrimary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 36.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Network',
                                style: fontTheme.textSmRegular
                                    ?.copyWith(color: colors.textSecondary)),
                            Row(
                              children: [
                                Image.asset(
                                  details.networkIconPath,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  details.networkName,
                                  style: fontTheme.textBaseMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 36.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fee',
                                style: fontTheme.textSmRegular
                                    ?.copyWith(color: colors.textSecondary)),
                            Text(
                                '${details.fee} ${details.feeCurrency} (≈ \$1.31)',
                                style: fontTheme.textBaseMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to confirm payment screen with withdraw details
                context.goNamed(
                  RouteConstants.confirmPayment,
                  extra: details,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: colors.brandDefault,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: Text(
                'Confirm',
                style: fontTheme.textBaseMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
