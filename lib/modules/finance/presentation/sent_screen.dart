import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/finance/presentation/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:defifundr_mobile/modules/finance/presentation/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SentScreen extends StatelessWidget {
  final WithdrawDetailsModel? withdrawDetails;

  const SentScreen({
    Key? key,
    this.withdrawDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
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

        return WillPopScope(
          onWillPop: () async {
            // Clear withdraw details and navigate to finance home
            context.read<WithdrawBloc>().add(const ClearWithdrawDetails());
            context.goNamed(RouteConstants.financeHome);
            return false;
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? colors.bgB1 // Light mode color
                : Colors.black,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    // Checkmark icon in a circle
                    const Spacer(),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: colors.brandDefault.withOpacity(
                              0.1), // Use a light brandDefault color for the circle, assuming it's close to brandPrimary
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 40,
                          color: colors
                              .brandDefault, // Use brandDefault color for the icon, assuming it's close to brandPrimary
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // "Sent!" text
                    Text(
                      'Sent!',
                      style: fontTheme.heading2Bold,
                    ),
                    const SizedBox(height: 8),
                    // Sent details text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: fontTheme.textBaseRegular.copyWith(
                          color: colors.textPrimary,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${details.amount}',
                            style: fontTheme.textBaseRegular.copyWith(
                              color: colors.textPrimary,
                              fontWeight:
                                  FontWeight.w600, // Semibold for amount
                            ),
                          ),
                          TextSpan(
                            text:
                                ' ${details.assetName} was successfully sent to',
                            style: fontTheme.textBaseRegular.copyWith(
                              color: colors
                                  .textPrimary, // Regular for asset name and rest
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      details.recipientAddress,
                      style: fontTheme.textBaseRegular.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // "View in Explorer" link
                    // TODO: Add functionality to open explorer link
                    TextButton(
                      onPressed: () {
                        // Add logic to open explorer link
                      },
                      child: Text(
                        'View in Explorer',
                        style: fontTheme.textBaseMedium.copyWith(
                            color: colors.brandDefault,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    // "Done" button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Clear withdraw details and navigate to finance home
                          context
                              .read<WithdrawBloc>()
                              .add(const ClearWithdrawDetails());
                          context.goNamed(RouteConstants.financeHome);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.brandDefault,
                          foregroundColor: colors.textWhite,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: fontTheme.textBaseMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
