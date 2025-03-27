import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

import '../../reset_password/verify_otp_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey();
  // final FocusNode _otpNode = FocusNode();
  // late final CountdownController _controller;
  final ValueNotifier<String> otp = ValueNotifier<String>("");
  final TextEditingController _otpController = TextEditingController();

  bool isCodeResent = false;
  final TextEditingController _pinController = TextEditingController();
  final int _pinLength = 6;
  String _pin = '';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/headset.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1A1A1A),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Need Help?',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Verify OTP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the OTP code sent to the email ending with test@defifundr.com',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    hapticFeedbackType: HapticFeedbackType.vibrate,
                    keyboardType: TextInputType.number,
                    controller: _otpController,
                    pinAnimationType: PinAnimationType.fade,
                    onChanged: (newOtp) {
                      setState(() {
                        otp.value = newOtp;
                      });
                    },
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend code 60secs',
                          style: TextStyle(
                            color: Color(0xFF505780),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color(0xFF1A1A1A),
                  ),
                  child: ElevatedButton(
                    onPressed: _pin.length == _pinLength ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      disabledBackgroundColor:
                          const Color(0xFF1A1A1A).withOpacity(0.5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Confirm OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
  }
}
