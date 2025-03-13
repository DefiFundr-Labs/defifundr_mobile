import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:flutter/material.dart';

class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final isValidate = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(context.screenWidth(), 60),
            child: const DeFiRaiseAppBar(
              title: '',
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
                              VerticalMargin(20),
                              Text(AppTexts.editEmail,
                                  style: Config.h2(context).copyWith()),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.editEmailDesc,
                                  style: Config.b1(context).copyWith(
                                    color: AppColors.grey100,
                                  )),
                              VerticalMargin(50),
                              AppTextField(
                                controller: _emailController,
                                hintText: AppTexts.fillEmail,
                                inputType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                focusNode: _emailNode,
                                textInputAction: TextInputAction.next,
                                validator: isValidate.value
                                    ? combine([
                                        withMessage(AppTexts.emailInvalid,
                                            isInvalidEmail),
                                        withMessage(
                                            AppTexts.fieldEmpty("Email"),
                                            isTextEmpty),
                                      ])
                                    : null,
                              ),

                              VerticalMargin(10),
                              // Login Button
                              AppButton(
                                text: AppTexts.resendOTP,
                                onTap: () {
                                  //FIXME: Navigate to login screen
                                },
                                textColor: AppColors.white100,
                                color: AppColors.primaryColor,
                              ),
                            ]))))));
  }
}
