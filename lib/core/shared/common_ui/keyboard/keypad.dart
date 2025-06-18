import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/shared/common_ui/keyboard/action_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/keyboard/keypad_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Keypad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback onBiometricPressed;
  final BiometricType biometricType;

  const Keypad({
    super.key,
    required this.onNumberPressed,
    required this.onBackspacePressed,
    required this.onBiometricPressed,
    required this.biometricType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKeypadRow(['1', '2', '3']),
        SizedBox(height: 24.h),
        _buildKeypadRow(['4', '5', '6']),
        SizedBox(height: 24.h),
        _buildKeypadRow(['7', '8', '9']),
        SizedBox(height: 24.h),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers
          .map((number) => KeypadButton(
                number: number,
                onPressed: () => onNumberPressed(number),
              ))
          .toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (biometricType != BiometricType.none)
          ActionButton(
            icon: biometricType == BiometricType.fingerprint
                ? Icons.fingerprint
                : Icons.face,
            onPressed: onBiometricPressed,
            size: 32,
          ),
        if (biometricType == BiometricType.none)
          SizedBox(
            width: 72.w,
            height: 72.h,
          ),
        KeypadButton(
          number: '0',
          onPressed: () => onNumberPressed('0'),
        ),
        ActionButton(
          icon: Icons.backspace_outlined,
          onPressed: onBackspacePressed,
          size: 24,
        ),
      ],
    );
  }
}
