import 'dart:async';

import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/bloc/sign_up_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/check_user_bloc/bloc/check_username_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatefulWidget {
  final String? email;
  final String? username;
  const CreateAccountScreen({this.email, this.username, super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isValidate = ValueNotifier<bool>(false);
  final FocusNode _emailNode = FocusNode();
  final FocusNode _firstNameNode = FocusNode();
  OverlayEntry? _overlayEntry;
  Timer? _debounceTimer;
  // Add debounce to search
  void debouncing({required Function() fn, int waitForMs = 500}) {
    // if this function is called before 500ms [waitForMs] expired
    //cancel the previous call
    _debounceTimer?.cancel();
    // set a 500ms [waitForMs] timer for the [fn] to be called
    _debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

  @override
  void initState() {
    _firstNameController.addListener(_checkChanged);
    _emailController.addListener(_checkChanged);
    if (widget.username != null) {
      setState(() {
        _firstNameController.text = widget.username!;
      });
    }
    if (widget.email != null) {
      setState(() {
        _emailController.text = widget.email!;
      });
    }

    super.initState();
  }

  void _checkChanged() {
    setState(() {
      if (_firstNameController.text.length > 3 &&
          _emailController.text.isNotEmpty &&
          // email validation regex
          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(_emailController.text)) {
        isValidate.value = true;
      } else {
        isValidate.value = false;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalMargin(50),
                  Text(AppTexts.createAccount,
                      style: Config.h2(context).copyWith(
                        fontSize: 24,
                      )),
                  // 📝 Note: The code below is the same as the one in the previous snippet.
                  Text(AppTexts.createAccountDescription,
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      )),
                  VerticalMargin(50),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return BlocConsumer<CheckUsernameBloc,
                          CheckUsernameState>(
                        listener: (context, stated) {
                          // TODO: do stuff here based on Bloc state
                        },
                        builder: (context, stated) {
                          return AppTextField(
                            controller: _firstNameController,
                            hintText: AppTexts.firstName,
                            inputType: TextInputType.name,
                            textCapitalization: TextCapitalization.none,
                            focusNode: _firstNameNode,
                            onChanged: (input) {
                              if (input.length > 3) {
                                debouncing(fn: () async {
                                  context
                                      .read<CheckUsernameBloc>()
                                      .add(CheckUsernameEq(username: input));
                                });
                              }
                            },
                            suffixIcon: stated.maybeWhen(
                              orElse: () => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 8.sp,
                                  width: 8.sp,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                    strokeWidth: 1.sp,
                                  ),
                                ),
                              ),
                              checkUsernameError: (check) => Icon(
                                Icons.error,
                                color: AppColors.errorColor,
                              ),
                              checkedUserLoaded: (check) => check == false
                                  ? SizedBox()
                                  : Icon(
                                      Icons.error,
                                      color: AppColors.errorColor,
                                    ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: isValidate.value
                                ? combine([
                                    withMessage(
                                        AppTexts.fieldEmpty("First Name"),
                                        isTextEmpty),
                                  ])
                                : null,
                          );
                        },
                      );
                    },
                  ),
                  VerticalMargin(20),
                  AppTextField(
                    controller: _emailController,
                    hintText: AppTexts.fillEmail,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    focusNode: _emailNode,
                    textInputAction: TextInputAction.done,
                    validator: isValidate.value
                        ? combine([
                            withMessage(AppTexts.emailInvalid, isInvalidEmail),
                            withMessage(
                                AppTexts.fieldEmpty("Email"), isTextEmpty),
                          ])
                        : null,
                  ),
                  VerticalMargin(20),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: _listener,
                    builder: (context, state) {
                      return BlocConsumer<CheckUsernameBloc,
                          CheckUsernameState>(
                        listener: _listenAndCheckUsername,
                        builder: (context, stated) {
                          return AppButton(
                            text: AppTexts.createAccountButton,
                            onTap: () {
                              _emailNode.unfocus();
                              _firstNameNode.unfocus();
                              //FIXME: Navigate to login screen

                              if (_formKey.currentState!.validate()) {
                                context.read<SignUpBloc>().add(RegisterUser(
                                    email: _emailController.text,
                                    username: _firstNameController.text));
                              } else {
                                context.showToast(
                                  title: AppTexts.emailInvalid,
                                  context: context,
                                  toastDurationInSeconds: 1,
                                  isSuccess: false,
                                );
                              }
                            },
                            textSize: 12.sp,
                            isActive: stated.maybeWhen(
                              orElse: () => false,
                              checkedUserLoaded: (check) {
                                return check == false && isValidate.value;
                              },
                            ),
                            textColor: AppColors.white100,
                            color: AppColors.primaryColor,
                          );
                        },
                      );
                    },
                  ),

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
                          context.goNamed(RouteConstants.login);
                        },
                        child: Text(
                          AppTexts.alreadyHaveAccount,
                          style: Config.b3(context).copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listenAndCheckUsername(BuildContext context, CheckUsernameState state) {
    state.maybeWhen(
        orElse: () {
          _overlayEntry?.remove();
        },
        checkingUsername: () {},
        checkUsernameError: (message) {
          context.showToast(
            title: message,
            context: context,
            toastDurationInSeconds: 1,
            isSuccess: false,
          );
        },
        checkedUserLoaded: (check) {
          if (check == true) {
            context.showToast(
              title: AppTexts.usernameAlreadyTaken,
              context: context,
              toastDurationInSeconds: 1,
              isSuccess: false,
            );
          }
        });
  }

  void _listener(BuildContext context, SignUpState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, checkedUserLoaded: (check) {
      if (check == true) {
        context.showToast(
          title: AppTexts.usernameAlreadyTaken,
          context: context,
          toastDurationInSeconds: 1,
          isSuccess: false,
        );
      }
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, registrationError: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
      if (message == AppTexts.incompleteRegistration) {
        context.goNamed(RouteConstants.verifyEmail, queryParameters: {
          "username": _firstNameController.text,
          "email": _emailController.text
        });
        return;
      }
    }, registrationSuccessful: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: "Please check your email to verify your account",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
      context.goNamed(RouteConstants.verifyEmail, queryParameters: {
        "username": _firstNameController.text,
        "email": _emailController.text
      });
    });
  }
}
