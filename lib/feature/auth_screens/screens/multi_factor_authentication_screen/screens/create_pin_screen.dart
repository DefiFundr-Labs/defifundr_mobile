import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/message_service.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/help_button.dart';
import '../widgets/pin_input.dart';
import '../widgets/pin_keypad.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<String> _pin = [];
  final int _pinLength = 4;
  String? _errorMessage;

  void _onKeyPressed(String key) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(key);
        _errorMessage = null;
      });

      if (_pin.length == _pinLength) {
        if (_isSequential(_pin.join())) {
          setState(() {
            _errorMessage = "Please avoid sequential numbers in your PIN";
          });
          MessageService.showError(context, "PIN code error!",
              "Please avoid sequential numbers in your PIN");

          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              _pin.clear();
            });
          });
          return;
        }

        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushNamed(
            context,
            '/confirm-pin',
            arguments: _pin,
          );
        });
      }
    }
  }

  bool _isSequential(String pin) {
    for (int i = 0; i < pin.length - 1; i++) {
      int current = int.parse(pin[i]);
      int next = int.parse(pin[i + 1]);
      if (next == current + 1 || next == current - 1) {
        if (i == pin.length - 2) {
          return true;
        }
      } else {
        return false;
      }
    }
    return false;
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

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB0 // Light mode color
          : colors.bgB1,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                      'Create Your PIN Code',
                      style: fonts.heading2SemiBold,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Enter a 4 digit code you will use to log in, without entering your login credentials.',
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
  }
}
