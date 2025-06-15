import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/message_service.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared/user_interface/buttons/help_button.dart';
import '../widgets/pin_input.dart';
import '../widgets/pin_keypad.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
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
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_originalPin != null && _pin.join() == _originalPin!.join()) {
            Navigator.pushNamed(context, '/pin-created');
          } else {
            setState(() {
              _errorMessage = "PINs do not match. Please try again.";
              _pin.clear();
            });
            MessageService.showError(context, "PIN code incorrect!",
                "PINs do not match. Please try again.");
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

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB1 // Light mode color
          : Colors.black,
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
                      'Confirm Your PIN Code',
                      style: fonts.heading2SemiBold,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Re-enter the PIN code to confirm and continue.',
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
