import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;

  const PinKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 50),
      color: const Color(0xFFEEEFF2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyButton(context, '1', ''),
              _buildKeyButton(context, '2', 'ABC'),
              _buildKeyButton(context, '3', 'DEF'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyButton(context, '4', 'GHI'),
              _buildKeyButton(context, '5', 'JKL'),
              _buildKeyButton(context, '6', 'MNO'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyButton(context, '7', 'PQRS'),
              _buildKeyButton(context, '8', 'TUV'),
              _buildKeyButton(context, '9', 'WXYZ'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 80.w),
              _buildKeyButton(context, '0', ''),
              _buildBackspaceButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyButton(BuildContext context, String number, String letters) {
    final fonts = context.theme.fonts;

    return Container(
      width: 117.w,
      height: 48.h,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => onKeyPressed(number),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: fonts.heading2Bold.copyWith(
                  fontSize: 28,
                ),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: fonts.textSmBold.copyWith(
                    letterSpacing: 2,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(BuildContext context) {
    return Container(
      width: 117.w,
      height: 48.h,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onBackspace,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
