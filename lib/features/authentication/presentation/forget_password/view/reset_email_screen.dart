import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/forget_password/state/bloc/forget_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetEmailScreen extends StatefulWidget {
  final String? user;
  const ResetEmailScreen({this.user, super.key});

  @override
  State<StatefulWidget> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  OverlayEntry? _overlayEntry;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final isValidate = ValueNotifier<bool>(false);

  @override
  void initState() {
    _emailNode.requestFocus();
    _emailController.addListener(_checkValidation);
    super.initState();
  }

  void _checkValidation() {
    setState(() {
      isValidate.value = _emailController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(context.screenWidth(), 60),
            child: DeFiRaiseAppBar(
              title: '',
              isBack: true,
            )),
        body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // VerticalMargin(20),
                              Text(AppTexts.resetPassword,
                                  style: Config.h2(context).copyWith(
                                    fontSize: 24,
                                  )),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.resetPasswordDesc,
                                  style: Config.b3(context).copyWith(
                                    color: AppColors.grey100,
                                  )),
                              VerticalMargin(50),
                              AppTextField(
                                controller: _emailController,
                                hintText: AppTexts.fillEmailLogin,
                                inputType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                focusNode: _emailNode,
                                textInputAction: TextInputAction.next,
                                validator: isValidate.value
                                    ? combine([
                                        withMessage(
                                            AppTexts.fieldEmpty("Email"),
                                            isTextEmpty),
                                      ])
                                    : null,
                              ),
                              VerticalMargin(20),

                              VerticalMargin(10),
                              // Login Button
                              BlocConsumer<ForgetPasswordBloc,
                                  ForgetPasswordState>(
                                listener: _listener,
                                builder: (context, state) {
                                  return AppButton(
                                    isActive: isValidate.value,
                                    text: AppTexts.resetPasswordButton,
                                    onTap: () {
                                      context.read<ForgetPasswordBloc>().add(
                                          ResetPasswordEvent(
                                              email: _emailController.text));
                                    },
                                    textSize: 12,
                                    textColor: AppColors.white100,
                                    color: AppColors.primaryColor,
                                  );
                                },
                              ),
                            ]))))));
  }

  void _listener(BuildContext context, ForgetPasswordState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, resetPasswordError: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, resetPasswordSuccess: (response) {
      _overlayEntry?.remove();
      context.goNamed(RouteConstants.resetOtp, queryParameters: {
        "email": _emailController.text,
      });
      context.showToast(
        title: "OTP has been sent to your email",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
    });
  }
}
