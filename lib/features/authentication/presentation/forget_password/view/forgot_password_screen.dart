import 'package:defifundr_mobile/core/global/constants/app_icons.dart';
import 'package:defifundr_mobile/core/global/constants/app_texts.dart';
import 'package:defifundr_mobile/core/global/constants/size.dart';
import 'package:defifundr_mobile/core/global/themes/color_scheme.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/button/buttons.dart';
import 'package:defifundr_mobile/core/shared/textfield/textfield.dart';
import 'package:defifundr_mobile/core/utils/input_validation.dart';
import 'package:defifundr_mobile/core/utils/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  final String? user;
  const ForgotPasswordScreen({this.user, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetEmailScreenState();
}

class _ResetEmailScreenState extends ConsumerState<ForgotPasswordScreen>
    with InputValidationMixin, LoadingOverlayMixin {
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
                              Text(AppTexts.forgotPassword,
                                  style: Config.h2(context).copyWith(
                                    fontSize: 24,
                                  )),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.forgotPasswordDesc,
                                  style: Config.b3(context).copyWith(
                                    color: AppColors.grey100,
                                  )),
                              VerticalMargin(50),
                              AppTextField(
                                controller: _emailController,
                                hintText: AppTexts.forgetPasswordLogin,
                                inputType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                focusNode: _emailNode,
                                textInputAction: TextInputAction.next,
                                prefixIcon: SvgPicture.asset(AppIcons.userIcon,
                                    fit: BoxFit.scaleDown),
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
                              AppButton(
                                isActive: isValidate.value,
                                text: AppTexts.forgotPasswordButton,
                                onTap: () {},
                                textSize: 12,
                                textColor: AppColors.white100,
                                color: AppColors.primaryColor,
                              )
                            ]))))));
  }
}
