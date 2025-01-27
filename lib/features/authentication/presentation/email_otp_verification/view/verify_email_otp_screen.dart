import 'package:defifundr_mobile/core/global/constants/app_icons.dart';
import 'package:defifundr_mobile/core/global/constants/app_images.dart';
import 'package:defifundr_mobile/core/global/constants/size.dart';
import 'package:defifundr_mobile/core/global/themes/color_scheme.dart';
import 'package:defifundr_mobile/core/routers/routes_constants.dart';
import 'package:defifundr_mobile/core/utils/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../core/global/constants/app_texts.dart';

class VerifyEmailOTPScreen extends ConsumerStatefulWidget {
  final String userName;
  final String userEmailAddress;
  const VerifyEmailOTPScreen(
      {required this.userName, required this.userEmailAddress, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailOTPScreenState();
}

class _VerifyEmailOTPScreenState extends ConsumerState<VerifyEmailOTPScreen>
    with LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _otpNode = FocusNode();
  late final CountdownController _controller;
  final ValueNotifier<String> otp = ValueNotifier<String>("");
  final TextEditingController _otpController = TextEditingController();

  bool isCodeResent = false;

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
      isCodeResent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.signup,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.arrowBack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.personSupport,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 50.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      height: 160.sp, width: 160.sp, AppImages.mailbox),
                  VerticalMargin(30),
                  Text(AppTexts.enterCode,
                      style: Config.h2(context).copyWith(
                        fontSize: 22.sp,
                      )),
                  VerticalMargin(5),
                  Text(widget.userEmailAddress,
                      style:
                          TextStyle(color: Color(0xFFA1A1A1), fontSize: 16.sp)),
                  VerticalMargin(20),
                  TextButton(
                    onPressed: () {
                      context.goNamed(RouteConstants.register,
                          queryParameters: {
                            "username": widget.userName,
                            "userEmailAddress": widget.userEmailAddress
                          });
                    },
                    child: Text(
                      AppTexts.changeEmail,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryColor),
                    ),
                  ),
                  VerticalMargin(25),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    listenForMultipleSmsOnAndroid: true,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
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
                  const VerticalMargin(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Countdown(
                        seconds: 180,
                        controller: _controller,
                        onFinished: () {
                          isCodeResent = true;
                        },
                        build: (BuildContext context, double time) {
                          isCodeResent = time.toInt() == 0;
                          return RichText(
                            text: TextSpan(
                                text: "${AppTexts.codeExpiresIn} ",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${(time ~/ 60).toString().padLeft(2, '0')} : ${(time % 60).toInt().toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                          );
                        },
                      ),
                    ],
                  ),
                  const VerticalMargin(40),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F4F7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(AppTexts.didntGetCode),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppTexts.resendCode,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
  width: 60,
  height: 56,
  textStyle: GoogleFonts.poppins(
    fontSize: 22,
    color: const Color.fromRGBO(30, 60, 87, 1),
  ),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2, color: const Color(0xFFE2E8F0))),
);
