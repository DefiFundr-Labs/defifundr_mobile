import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/bloc/sign_up_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/verify_bloc/bloc/verify_otp_bloc.dart';
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

class VerifyOTPScreen extends StatefulWidget {
  final String username;
  final String email;
  const VerifyOTPScreen(
      {required this.username, required this.email, super.key});

  @override
  State<StatefulWidget> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen>
    with LoadingOverlayMixin {
  final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<String> otp = ValueNotifier<String>("");
  final TextEditingController _otpController = TextEditingController();
  late final CountdownController _controller;
  OverlayEntry? _overlayEntry;

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
      // appBar: PreferredSize(
      //   preferredSize: Size(context.screenWidth(), 60),
      //   child: const DeFiRaiseAppBar(
      //     title: 'Notifications',
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 50.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalMargin(20),
                  Text(AppTexts.verifyOTP,
                      style: Config.h2(context).copyWith(
                        fontSize: 22.sp,
                      )),
                  VerticalMargin(5),
                  // 📝 Note: The code below is the same as the one in the previous snippet.
                  Text(AppTexts.verifyOTPDescription("email"),
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      )),
                  VerticalMargin(50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
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
                    padding: EdgeInsets.only(left: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(AppTexts.notYourEmail(widget.email),
                            style: Config.b3(context).copyWith(
                              fontSize: 12.sp,
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
                            context.goNamed(RouteConstants.register,
                                queryParameters: {
                                  "username": widget.username,
                                  "email": widget.email
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
                  const VerticalMargin(5),
                  BlocConsumer<SignUpBloc, SignUpState>(
                      listener: _listener,
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.sp),
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
                                        ? () async {
                                            context
                                                .read<SignUpBloc>()
                                                .add(ResendOtp(
                                                  username: widget.username,
                                                ));
                                          }
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
                        );
                      }),
                  const VerticalMargin(30),
                  BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                    listener: _listenerToVerification,
                    builder: (context, state) {
                      return AppButton(
                        onTap: () {
                          context.read<VerifyOtpBloc>().add(VerifyOtpEq(
                                otp: _otpController.text,
                                username: widget.username,
                              ));
                          // context.goNamed(RouteConstants.confirmPassword);
                        },
                        isActive: _otpController.text.length == 6,
                        textSize: 12.sp,
                        text: AppTexts.verify,
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

  void _listenerToVerification(BuildContext context, VerifyOtpState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, otpVerificationError: (error) {
      _overlayEntry?.remove();

      context.showToast(
        title: error,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, verifyingOtp: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, otpVerificationSuccessful: (success) {
      _overlayEntry?.remove();

      context.goNamed(RouteConstants.confirmPassword,
          queryParameters: {"username": widget.username});
    });
  }

  void _listener(BuildContext context, SignUpState state) {
    state.maybeWhen(
        orElse: () {
          if (_overlayEntry != null) {
            _overlayEntry?.remove();
          }
        },
        verifyingOtp: () {
          _overlayEntry = showLoadingOverlay(context, _overlayEntry);
        },
        loading: () {
          _overlayEntry = showLoadingOverlay(context, _overlayEntry);
        },
        registrationError: (message) {
          _overlayEntry?.remove();

          context.showToast(
            title: message,
            context: context,
            toastDurationInSeconds: 1,
            isSuccess: false,
          );
        },
        otpVerificationError: (message) {
          _overlayEntry?.remove();

          context.showToast(
            title: message,
            context: context,
            toastDurationInSeconds: 1,
            isSuccess: false,
          );
        },
        otpResendError: (message) {
          _overlayEntry?.remove();

          context.showToast(
            title: message,
            context: context,
            toastDurationInSeconds: 1,
            isSuccess: false,
          );
        },
        otpResendSuccessful: (message) {
          _overlayEntry?.remove();

          context.showToast(
            title: message,
            context: context,
            toastDurationInSeconds: 1,
            isSuccess: true,
          );
          _restartTimer();
        },
        registrationSuccessful: (message) {});
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
