import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/keyboard/keypad.dart';
import 'package:defifundr_mobile/core/shared/shared_services/heptics/heptic_manager.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/widget/pin_input_section.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_state.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/widget/two_fa_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()

class TwoFaAuthScreen extends StatefulWidget {
  const TwoFaAuthScreen({super.key});

  @override
  State<TwoFaAuthScreen> createState() => _TwoFaAuthScreenState();
}

class _TwoFaAuthScreenState extends State<TwoFaAuthScreen>
    with TickerProviderStateMixin {
  final List<String> _pin = [];
  final int _pinLength = 6;
  String? _errorMessage;
  late Animation<double> _shakeAnimation;
  late AnimationController _shakeController;
  bool _showError = true;

  @override
  void initState() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticOut,
    ));
    super.initState();
  }

  void _onBiometricPressed() {
    HapticManager.lightImpact();
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
        _showError = false;
      });
      HapticManager.lightImpact();
    }
  }

  void _onNumberPressed(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(number);
        _showError = false;
      });

      HapticManager.lightImpact();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          // Complete the withdraw process
          context.read<WithdrawBloc>().add(const CompleteWithdraw());
          // Navigate to sent screen
          context.router.replace(const SentRoute());
        }
      });
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
        if (state.withdrawDetails == null) {
          return Scaffold(
            body: Center(
              child: Text('Error: Withdraw details not found'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? colors.bgB0 // Light mode color
              : colors.bgB1,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TwoFaAuthHeader(),
                        SizedBox(height: 32.h),
                        PinInputSection(
                          pinLength: _pinLength,
                          currentPinLength: _pin.length,
                          showError: _showError,
                          errorMessage: _errorMessage ?? "",
                          shakeAnimation: _shakeAnimation,
                        ),
                        const Spacer(),
                        Keypad(
                          onNumberPressed: _onNumberPressed,
                          onBackspacePressed: _onBackspacePressed,
                          onBiometricPressed: _onBiometricPressed,
                          biometricType: BiometricType.none,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
