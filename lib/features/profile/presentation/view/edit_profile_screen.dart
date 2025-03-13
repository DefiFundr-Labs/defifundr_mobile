import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/login/states/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/bloc/sign_up_bloc.dart';
import 'package:defiraiser_mobile/features/profile/presentation/state/change_username_bloc/bloc/change_username_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  final TextEditingController _userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isValidate = ValueNotifier<bool>(false);
  final isActive = ValueNotifier<bool>(false);
  final FocusNode _userNameNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _userNameController.dispose();
    _userNameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: true,
          title: AppTexts.editProfile,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return AppTextField(
                        controller: _userNameController,
                        hintText: AppTexts.firstName,
                        inputType: TextInputType.name,
                        textCapitalization: TextCapitalization.none,
                        focusNode: _userNameNode,
                        onChanged: (input) {
                          final isValid = _formKey.currentState!.validate();
                          debugPrint("isValid: $isValid");
                          if (input.isNotEmpty && input.length > 4) {
                            context
                                .read<SignUpBloc>()
                                .add(CheckUsernameEvent(username: input));
                            setState(() {
                              isValidate.value = true;
                            });
                          } else {
                            // validate
                            setState(() {
                              isValidate.value = false;
                            });
                          }
                        },
                        suffixIcon: state.maybeWhen(
                          orElse: () => Icon(
                            Icons.info,
                            color: Colors.orange,
                          ),
                          checkUsernameError: (check) => Icon(
                            Icons.error,
                            color: AppColors.errorColor,
                          ),
                          checkedUserLoaded: (check) => check == false &&
                                  _userNameController.text.isNotEmpty &&
                                  _userNameController.text.length > 4
                              ? Icon(
                                  Icons.check_box,
                                  color: AppColors.successColor,
                                )
                              : Icon(
                                  Icons.error,
                                  color: AppColors.errorColor,
                                ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: isValidate.value
                            ? combine([
                                withMessage(
                                    AppTexts.fieldEmpty("Please username"),
                                    isTextEmpty),
                                withMessage(
                                    AppTexts.fieldEmpty(
                                        "Please enter valid username"),
                                    isValidUsername),
                              ])
                            : null,
                      );
                    },
                  ),
                  VerticalMargin(20),
                  BlocConsumer<ChangeUsernameBloc, ChangeUsernameState>(
                    listener: _listenerUserChangeChange,
                    builder: (context, state) {
                      return BlocConsumer<SignUpBloc, SignUpState>(
                        listener: _listener,
                        builder: (context, state) {
                          return AppButton(
                            text: AppTexts.continueTo,
                            isActive: state.maybeWhen(
                              orElse: () => false,
                              checkUsernameError: (check) => false,
                              checkedUserLoaded: (check) {
                                if (_userNameController.text.isNotEmpty &&
                                    _userNameController.text.length > 4 &&
                                    check == false) {
                                  return true;
                                }
                                return false;
                              },
                            ),
                            onTap: () {
                              _userNameNode.unfocus();
                              if (_formKey.currentState!.validate()) {
                                context.read<ChangeUsernameBloc>().add(
                                    ChangeUsernameEq(
                                        username: _userNameController.text));
                              } else {
                                setState(() {
                                  isValidate.value = true;
                                });
                              }
                            },
                            textSize: 12,
                            textColor: AppColors.white100,
                            color: AppColors.primaryColor,
                          );
                        },
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

  void _listenerUserChangeChange(
      BuildContext context, ChangeUsernameState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, error: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, loaded: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: "Username changed successfully",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
      context.pop();
      context.read<GetUserDetailsBloc>().add(GetUserEventEq());
    });
  }

  void _listener(BuildContext context, SignUpState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, checkingUsername: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, checkUsernameError: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, checkedUserLoaded: (message) {
      _overlayEntry?.remove();
    });
  }
}
