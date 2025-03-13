import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/login/states/bloc/login_state_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/login/states/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final FocusNode _passwordNode = FocusNode();
  final isValidate = ValueNotifier<bool>(false);
  final isHide = ValueNotifier<bool>(true);

  @override
  void initState() {
    _emailNode.requestFocus();
    _emailController.addListener(_checkValidation);
    _passwordController.addListener(_checkValidation);
    super.initState();
  }

  void _checkValidation() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        isValidate.value = true;
      } else {
        isValidate.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              VerticalMargin(20),
                              Text(
                                AppTexts.login,
                                style: Config.h2(context).copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.loginDesc,
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
                              AppTextField(
                                hintText: AppTexts.password,
                                controller: _passwordController,
                                inputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                focusNode: _passwordNode,
                                obscureText: isHide.value,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isHide.value = !isHide.value;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SvgPicture.asset(
                                        isHide.value
                                            ? AppIcons.eye
                                            : AppIcons.eyeSplash,
                                        color: AppColors.grey100.withAlpha(100),
                                        height: 10,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              VerticalMargin(20),
                              // Forget Details and Biometrics in Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.goNamed(
                                          RouteConstants.resetPassword);
                                    },
                                    style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: Text(
                                      AppTexts.forgetDetails,
                                      style: Config.b3(context).copyWith(
                                        fontSize: 12,
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              VerticalMargin(10),
                              // Login Button
                              BlocConsumer<LoginStateBloc, LoginState>(
                                  listener: _listener,
                                  builder: (context, state) {
                                    return AppButton(
                                      text: AppTexts.login,
                                      isActive: isValidate.value,
                                      onTap: () async {
                                        context
                                            .read<LoginStateBloc>()
                                            .add(LoginInUserEvent(
                                              user: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ));
                                      },
                                      textColor: AppColors.white100,
                                      textSize: 12,
                                      color: AppColors.primaryColor,
                                    );
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all(
                                        Colors.transparent,
                                      ),
                                    ),
                                    onPressed: () {
                                      context.goNamed(RouteConstants.register);
                                    },
                                    child: Text(
                                      AppTexts.dontHaveAccount,
                                      style: Config.b3(context).copyWith(
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]))))));
  }

  void _listener(BuildContext context, LoginState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, authenticationFailed: (message) {
      _overlayEntry?.remove();
      if (message == AppTexts.userNotVerified) {
        context.read<SignUpBloc>().add(ResendOtp(
              username: _emailController.text,
            ));
        context.goNamed(RouteConstants.verifyEmail,
            queryParameters: {"username": _emailController.text});
      }
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, loginSuccessful: (response) {
      _overlayEntry?.remove();
      context.read<GetUserDetailsBloc>().add(GetUserEventEq());

      if (!response.data!.user.isFirstTime) {
        context.goNamed(RouteConstants.selectAvatar);
      } else {
        context.goNamed(RouteConstants.home);
      }
    });
  }
}
