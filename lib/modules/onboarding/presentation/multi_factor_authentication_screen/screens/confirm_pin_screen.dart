import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/keyboard/keypad.dart';
import 'package:defifundr_mobile/core/shared/shared_services/heptics/heptic_manager.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/widget/pin_input_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({
    super.key,
  });

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen>
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
        Future.delayed(const Duration(milliseconds: 100), _verifyPin);
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
    context.router.push(PinCreatedRoute());
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
    // Implement biometric authentication
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          isBack: true,
          title: '',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                'Confirm Your PIN Code',
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24.sp,
                  color: context.theme.colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Enter a 4 digit code you will use to log in, without entering your login credentials.',
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.theme.colors.textSecondary,
                ),
              ),
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
                biometricType: BiometricType.none,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
