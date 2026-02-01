import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/app_texts.dart';
import '../../../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../../../../../core/shared/common_ui/buttons/primary_button.dart';
import '../../../../../core/utils/message_service.dart';
import '../bloc/forgot_password_bloc.dart';

@RoutePage()
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late final CountdownNotifier _countdownNotifier;
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  final StreamController<ErrorAnimationType> _errorController =
      StreamController();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _countdownNotifier = CountdownNotifier();
  }

  @override
  void dispose() {
    _countdownNotifier.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_hasError) {
      setState(() => _hasError = false);
    }
  }

  void _handleOtpVerification() {
    if (_otpController.text.length != 6) {
      setState(() => _hasError = true);
      MessageService.showError(
        context,
        AppTexts.invalidOTPCode,
        AppTexts.invalidOTPCodeDesc,
      );
      return;
    }

    context.router.push(const NewPasswordRoute());
  }

  void _handleResendOtp() {
    MessageService.showSuccess(
      context,
      AppTexts.otpCodeResent,
      AppTexts.otpCodeResentDesc,
    );

    context.read<ForgotPasswordBloc>().add(ResendOtpEvent());
    _countdownNotifier.start();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildOtpInput(),
            const SizedBox(height: 24),
            _buildInfoCard(),
            const Expanded(child: SizedBox()),
            _buildVerifyButton(),
            SizedBox(height: 10.sp),
            _buildResendButton(),
            _buildBottomSpacing(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify OTP",
          style: context.theme.fonts.heading2Bold,
        ),
        const SizedBox(height: 4),
        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          buildWhen: (previous, current) =>
              previous.emailAddress != current.emailAddress,
          builder: (context, state) {
            return RichText(
              text: TextSpan(
                text: "Please enter the 6 digit OTP code sent to ",
                style: context.theme.fonts.textMdRegular.copyWith(
                  color: context.theme.colors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: state.emailAddress ?? 'tempuser12346@mail.com',
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.brandDefaultContrast,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.enterCode,
          style: context.theme.fonts.textMdMedium,
        ),
        const SizedBox(height: 8),
        BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordError) {
              setState(() => _hasError = true);
            }
          },
          builder: (context, state) {
            return PinCodeTextField(
              appContext: context,
              backgroundColor: isDark
                  ? context.theme.colors.bgB0
                  : context.theme.colors.bgB1,
              useHapticFeedback: true,
              obscuringCharacter: '●',
              length: 6,
              obscureText: true,
              showCursor: true,
              autoDismissKeyboard: true,
              autovalidateMode: AutovalidateMode.disabled,
              controller: _otpController,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              textStyle: context.theme.fonts.bodyMedium.copyWith(
                fontSize: 20.sp,
              ),
              cursorColor: context.theme.colors.brandDefault,
              cursorHeight: 18.sp,
              focusNode: _otpFocusNode,
              errorAnimationController: _errorController,
              onCompleted: (value) {
                if (value.length == 6 && value == "123456") {
                  _handleOtpVerification();
                } else {
                  _errorController.onListen!();
                  MessageService.showError(
                    context,
                    AppTexts.invalidOTPCode,
                    AppTexts.invalidOTPCodeDesc,
                  );
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldWidth: 52,
                fieldHeight: 52,
                borderWidth: 2,
                activeColor: _hasError
                    ? context.theme.colors.redDefault
                    : context.theme.colors.brandDefaultContrast,
                inactiveColor: _hasError
                    ? context.theme.colors.redDefault
                    : context.theme.colors.strokeSecondary,
                selectedColor: _hasError
                    ? context.theme.colors.redDefault
                    : context.theme.colors.brandDefaultContrast,
                activeFillColor: context.theme.colors.bgB1,
                inactiveFillColor: context.theme.colors.bgB1,
                selectedFillColor: isDark
                    ? context.theme.colors.bgB1
                    : context.theme.colors.bgB0,
              ),
              enableActiveFill: true,
              onChanged: (value) => _clearError(),
              validator: _hasError ? (value) => '' : null,
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colors.strokeSecondary),
        borderRadius: BorderRadius.circular(12),
        color: isDark ? context.theme.colors.bgB1 : context.theme.colors.bgB0,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Assets.icons.info,
            height: 20,
            color: context.theme.colors.graySecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppTexts.cantFindCode,
                  style: context.theme.fonts.textMdSemiBold,
                ),
                Text(
                  "Try checking your junk/spam folder, or resend the code.",
                  style: context.theme.fonts.textSmRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {}
      },
      child: PrimaryButton(
        text: "Verify code",
        onPressed: _handleOtpVerification,
      ),
    );
  }

  Widget _buildResendButton() {
    return ValueListenableBuilder<int>(
      valueListenable: _countdownNotifier,
      builder: (context, countdown, child) {
        final isEnabled = countdown == 60;
        final countdownText = countdown == 60
            ? ''
            : '\t(00:${countdown > 9 ? countdown : '0$countdown'})';

        return PrimaryButton(
          text: "${AppTexts.resendCode}$countdownText",
          textColor: context.theme.colors.textPrimary,
          color: context.theme.colors.fillTertiary,
          icon: Assets.icons.arrowClockwise,
          iconColor: Colors.black,
          isEnabled: isEnabled,
          onPressed: isEnabled ? _handleResendOtp : null,
        );
      },
    );
  }

  Widget _buildBottomSpacing() {
    return Column(
      children: [
        if (MediaQuery.viewInsetsOf(context).bottom < 10)
          SizedBox(
            height: 8 + MediaQuery.systemGestureInsetsOf(context).bottom,
          ),
        SizedBox(height: 20.sp),
      ],
    );
  }
}

class CountdownNotifier extends ValueNotifier<int> {
  CountdownNotifier() : super(60);

  Timer? _timer;

  void start() {
    _timer?.cancel();
    value = 59;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (value > 0) {
        value--;
      } else {
        timer.cancel();
        value = 60;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
