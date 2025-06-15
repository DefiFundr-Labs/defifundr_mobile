import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/message_service.dart';
import 'package:defifundr_mobile/feature/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/core/shared/user_interface/buttons/help_button.dart';
import 'package:defifundr_mobile/feature/onboarding/presentation/multi_factor_authentication_screen/widgets/pin_input.dart';
import 'package:defifundr_mobile/feature/onboarding/presentation/multi_factor_authentication_screen/widgets/pin_keypad.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/feature/finance/presentation/withdraw_details_model.dart';
import 'package:defifundr_mobile/feature/finance/presentation/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/feature/finance/presentation/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final WithdrawDetailsModel? withdrawDetails;

  const ConfirmPaymentScreen({
    super.key,
    this.withdrawDetails,
  });

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  final List<String> _pin = [];
  final int _pinLength = 4;
  List<String>? _originalPin;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<String>) {
      _originalPin = args;
    }
  }

  void _onKeyPressed(String key) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(key);
        _errorMessage = null;
      });

      if (_pin.length == _pinLength) {
        // Get withdraw details from bloc state
        final withdrawDetails =
            context.read<WithdrawBloc>().state.withdrawDetails;

        // TODO: Implement actual PIN confirmation logic here when integrating.
        // For simplicity, navigating directly to 2FA screen after a delay.
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            // Check if the widget is still mounted before navigating
            // TODO: Add comment: Actual PIN validation would happen here before navigating.
            // For now, we assume the PIN is confirmed for navigation purposes.
            context.goNamed(
              RouteConstants.twoFaAuth,
              extra: withdrawDetails,
            );
          }
        });
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        // Use withdraw details from constructor if available, otherwise from bloc state
        final details = widget.withdrawDetails ?? state.withdrawDetails;

        if (details == null) {
          return Scaffold(
            body: Center(
              child: Text('Error: Withdraw details not found'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: colors.bgB1,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomBackButton(),
                      const HelpButton(),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          'Enter Your PIN Code',
                          style: fonts.heading2SemiBold,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Enter your 4 digit PIN code to complete this transaction',
                          style: fonts.textMdRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          'Enter PIN',
                          style: fonts.textBaseMedium,
                        ),
                        SizedBox(height: 16.h),
                        PinInput(
                          pinValues: _pin,
                          activeIndex: _pin.length,
                          pinLength: _pinLength,
                          hasError: _errorMessage != null,
                        ),
                      ],
                    ),
                  ),
                ),
                PinKeypad(
                  onKeyPressed: _onKeyPressed,
                  onBackspace: _onBackspace,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
