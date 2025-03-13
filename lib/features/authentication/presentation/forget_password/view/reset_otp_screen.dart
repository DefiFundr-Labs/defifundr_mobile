import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/forget_password/state/bloc/forget_password_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/widgets/resend_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../core/global/constants/app_texts.dart';

class ResetOTPScreen extends StatefulWidget {
  final String email;
  const ResetOTPScreen({required this.email, super.key});

  @override
  State<StatefulWidget> createState() => _ResetOTPScreenState();
}

class _ResetOTPScreenState extends State<ResetOTPScreen> {
  final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<String> otp = ValueNotifier<String>("");
  final TextEditingController _otpController = TextEditingController();
  late final CountdownController _controller;

  bool canResend = false;
  final FocusNode _otpNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _otpNode.requestFocus();
    _controller = CountdownController(
      autoStart: true,
    );
  }

  void _restartTimer() {
    _controller.restart();
    setState(() {
      canResend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            title: '',
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalMargin(20),
                  Text(AppTexts.resetOTP,
                      style: Config.h2(context).copyWith(
                        fontSize: 24,
                      )),
                  VerticalMargin(5),
                  // 📝 Note: The code below is the same as the one in the previous snippet.
                  Text(AppTexts.verifyOTPDescription("email"),
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      )),
                  VerticalMargin(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      listenForMultipleSmsOnAndroid: true,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      length: 6,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      hapticFeedbackType: HapticFeedbackType.vibrate,
                      keyboardType: TextInputType.number,
                      controller: _otpController,
                      pinAnimationType: PinAnimationType.rotation,
                      onChanged: (newOtp) {
                        setState(() {
                          otp.value = newOtp;
                        });
                        if (otp.value.isNotEmpty && otp.value.length == 6) {
                          setState(() {
                            isEnabled.value = true;
                          });
                        } else {
                          setState(() {
                            isEnabled.value = false;
                          });
                        }
                      },
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const VerticalMargin(30),
                  // Not your Email? Change it
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(AppTexts.notYourEmail(widget.email),
                            style: Config.b3(context).copyWith(
                              color: AppColors.grey100.withOpacity(0.5),
                            )),
                        const HorizontalMargin(2),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            enableFeedback: false,
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)),
                          ),
                          onPressed: () {
                            context.goNamed(RouteConstants.resetPassword,
                                queryParameters: {
                                  "user": widget.email,
                                });
                          },
                          child: Text(
                            "Edit Email",
                            style: Config.b3(context).copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const VerticalMargin(30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Countdown(
                          seconds: 60,
                          controller: _controller,
                          onFinished: () {
                            canResend = true;
                          },
                          build: (BuildContext context, double time) {
                            canResend = time.toInt() == 0;
                            return GestureDetector(
                              onTap: canResend
                                  // ignore: unnecessary_lambdas
                                  ? () async {}
                                  : null,
                              child: bottomTexts(
                                context: context,
                                buttonText: canResend
                                    ? 'Resend code'
                                    : 'Resend OTP '
                                        '0 : ${time.toInt().toString()} seconds',
                                text: 'Didn’t get the code?',
                                textColor: canResend
                                    ? AppColors.secondaryColor
                                    : AppColors.grey100,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalMargin(30),
                  BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return AppButton(
                        text: AppTexts.verifyOTP,
                        isActive: _otpController.text.length == 6,
                        onTap: () {
                          context.goNamed(RouteConstants.resetConfirmPassword,
                              queryParameters: {
                                "otp": _otpController.text,
                                "email": widget.email
                              });
                        },
                        textSize: 12,
                        textColor: AppColors.white100,
                        color: AppColors.primaryColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        // Add bottom border for every pin
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: const Color.fromRGBO(30, 60, 87, 1),
          ),
        ),
      ));
}
