import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/app_texts.dart';
import '../../../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../../../../../core/shared/user_interface/buttons/primary_button.dart';
import '../../../../../core/utils/message_service.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late _CountdownNotifier _countdownNotifier;
  final _otpController = TextEditingController();
  bool _hasError = false;

  @override
  void initState() {
    _countdownNotifier = _CountdownNotifier();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VerifyOtpScreen oldWidget) {
    _countdownNotifier.dispose();
    _countdownNotifier = _CountdownNotifier();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _countdownNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colors.bgB0,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colors.bgB0,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border:
                    Border.all(color: Theme.of(context).colors.textPrimary)),
            child: Row(
              spacing: 4,
              children: [
                Icon(Icons.headphones_outlined,
                    size: 16,
                    applyTextScaling: true,
                    color: Theme.of(context).colors.textPrimary),
                Text(AppTexts.needHelp,
                    style: Theme.of(context).fonts.textSmMedium)
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTexts.verifyOTP,
                style: Theme.of(context).fonts.heading2Bold),
            SizedBox(height: 4),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return RichText(
                  text: TextSpan(
                    text: AppTexts.verifyOTPDesc,
                    style: Theme.of(context).fonts.textMdRegular,
                    children: [
                      TextSpan(
                        text:
                            "\t${state.emailAddress ?? 'tempuser12346@mail.com'}",
                        style: Theme.of(context).fonts.textMdSemiBold.copyWith(
                            color:
                                Theme.of(context).colors.brandDefaultContrast),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Text(AppTexts.enterCode,
                style: Theme.of(context).fonts.textMdMedium),
            SizedBox(height: 8),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordError) _hasError = true;
              },
              builder: (context, state) {
                return PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  showCursor: false,
                  autoDismissKeyboard: true,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  controller: _otpController,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    activeColor: _hasError
                        ? Theme.of(context).colors.redDefault
                        : Theme.of(context).colors.strokeSecondary,
                    inactiveColor: _hasError
                        ? Theme.of(context).colors.redDefault
                        : Theme.of(context).colors.strokeSecondary,
                    selectedColor: _hasError
                        ? Theme.of(context).colors.redDefault
                        : Theme.of(context).colors.brandDefaultContrast,
                    activeFillColor: Theme.of(context).colors.bgB1,
                    inactiveFillColor: Theme.of(context).colors.bgB1,
                    selectedFillColor: Theme.of(context).colors.bgB1,
                    fieldWidth: 52,
                    fieldHeight: 52,
                    borderWidth: 2,
                  ),
                  enableActiveFill: true,
                  onChanged: (value) {
                    if (!_hasError) return;
                    setState(() => _hasError = false);
                  },
                  validator: (value) {
                    if (_hasError) return '';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textStyle: Theme.of(context).fonts.heading1Regular,
                );
              },
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colors.strokeSecondary),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colors.bgB1,
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.info,
                    size: 20,
                    applyTextScaling: true,
                    color: Theme.of(context).colors.graySecondary,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppTexts.cantFindCode,
                          style: Theme.of(context).fonts.textMdSemiBold),
                      Text(AppTexts.cantFindCodeDesc,
                          style: Theme.of(context).fonts.textSmRegular),
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  // handle navigation to new_password or perform navigation within the bloc
                }
              },
              child: PrimaryButton(
                text: AppTexts.resetPassword,
                textColor: Theme.of(context).colors.contrastWhite,
                color: Theme.of(context).colors.contrastBlack,
                onPressed: () {
                  MessageService.showError(context, AppTexts.invalidOTPCode,
                      AppTexts.invalidOTPCodeDesc);
                  context
                      .read<ForgotPasswordBloc>()
                      .add(VerifyOtpEvent(_otpController.text));
                },
              ),
            ),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return ValueListenableBuilder(
                  valueListenable: _countdownNotifier,
                  builder: (context, value, child) {
                    return PrimaryButton(
                      text:
                          "${AppTexts.resendCode}${value == 60 ? '' : '\t(00:${value > 9 ? value : '0$value'})'}",
                      textColor: Theme.of(context).colors.textPrimary,
                      color: Theme.of(context).colors.fillTertiary,
                      // icon: Icons.refresh,
                      isEnabled: value == 60,
                      onPressed: () {
                        MessageService.showSuccess(context,
                            AppTexts.otpCodeResent, AppTexts.otpCodeResentDesc);
                        context
                            .read<ForgotPasswordBloc>()
                            .add(ResendOtpEvent());
                        _countdownNotifier.start();
                      },
                    );
                  },
                );
              },
            ),
            if (MediaQuery.viewInsetsOf(context).bottom < 10)
              SizedBox(
                  height: 8 + MediaQuery.systemGestureInsetsOf(context).bottom)
          ],
        ),
      ),
    );
  }
}

class _CountdownNotifier extends ValueNotifier<int> {
  _CountdownNotifier() : super(60);

  void start() {
    value--;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (value > 0) {
        value--;
      } else {
        timer.cancel();
        value = 60;
      }
    });
  }
}
