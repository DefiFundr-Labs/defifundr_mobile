import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/keyboard/keypad.dart';
import 'package:defifundr_mobile/core/shared/shared_services/heptics/heptic_manager.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/widget/pin_input_section.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/widget/pin_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final WithdrawDetailsModel? withdrawDetails;

  const ConfirmPaymentScreen({
    super.key,
    this.withdrawDetails,
  });

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen>
    with TickerProviderStateMixin {
  static const int _pinLength = 4;
  static const String _correctPin = "1234";

  final List<String> _pin = [];
  bool _showError = false;
  String _errorMessage = '';

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
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
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onNumberPressed(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(number);
        _showError = false;
      });

      HapticManager.lightImpact();

      if (_pin.length == _pinLength) {
        final withdrawDetails =
            context.read<WithdrawBloc>().state.withdrawDetails;

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.goNamed(
              RouteConstants.twoFaAuth,
              extra: withdrawDetails,
            );
          }
        });
      }
    }
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

  void _verifyPin() {
    final enteredPin = _pin.join();

    if (enteredPin == _correctPin) {
      _handleSuccessfulLogin();
    } else {
      _handleIncorrectPin();
    }
  }

  void _handleSuccessfulLogin() {
    HapticManager.lightImpact();
    // Navigate to next screen or handle success
  }

  void _handleIncorrectPin() {
    HapticManager.heavyImpact();

    setState(() {
      _showError = true;
      _errorMessage = 'Incorrect PIN. Please try again.';
    });

    _shakeController.forward().then((_) => _shakeController.reset());

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _pin.clear();
          _showError = false;
        });
      }
    });
  }

  void _onBiometricPressed() {
    HapticManager.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              ConfirmPinHeader(),
              SizedBox(height: 20.h),
              PinInputSection(
                pinLength: _pinLength,
                currentPinLength: _pin.length,
                showError: _showError,
                errorMessage: _errorMessage,
                shakeAnimation: _shakeAnimation,
              ),
              const Spacer(),
              Keypad(
                onNumberPressed: _onNumberPressed,
                onBackspacePressed: _onBackspacePressed,
                onBiometricPressed: _onBiometricPressed,
                biometricType: BiometricType.fingerprint,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
