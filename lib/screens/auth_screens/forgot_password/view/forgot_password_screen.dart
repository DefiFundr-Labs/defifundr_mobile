import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ForgotPasswordScreen> {
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
    return BlocProvider(
        create: (_) => ForgotPasswordBloc(),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error),
                  backgroundColor: AppColors.errorColor),
            );
          } else if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.successColor),
            );
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.backgroundImage, // Your SVG background asset
                  fit: BoxFit.cover, // Ensures it fills the entire screen
                ),
              ),
              Scaffold(
                backgroundColor:
                    Colors.transparent, // Make Scaffold transparent
                appBar: PreferredSize(
                  preferredSize: Size(context.screenWidth(), 60),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: SvgPicture.asset(AppAssets.backArrow),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 50),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppTexts.forgotPassword,
                                style:
                                    Config.h2(context).copyWith(fontSize: 24)),
                            VerticalMargin(5),
                            Text(AppTexts.forgotPasswordDesc,
                                style: Config.b3(context).copyWith(
                                  color: AppColors.grey100,
                                )),
                            VerticalMargin(50),
                            AppTextField(
                              controller: _emailController,
                              label: AppTexts.forgetPasswordLogin,
                              // inputType: TextInputType.emailAddress,
                              focusNode: _emailNode,
                              prefixIcon: SvgPicture.asset(AppAssets.userIcon,
                                  fit: BoxFit.scaleDown),
                            ),
                            VerticalMargin(20),
                            AppButton(
                              text: AppTexts.forgotPasswordButton,
                              onTap: () {
                                context.read<ForgotPasswordBloc>().add(
                                      SubmitEmail(_emailController.text),
                                    );
                              },
                              textSize: 12,
                              borderRadius: 47.sp,
                              textColor: AppColors.white100,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
