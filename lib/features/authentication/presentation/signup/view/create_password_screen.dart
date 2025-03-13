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
import 'package:defiraiser_mobile/features/authentication/presentation/signup/states/create_password_bloc/bloc/create_password_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String username;
  const CreatePasswordScreen({required this.username, super.key});

  @override
  State<StatefulWidget> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen>
    with
        InputValidationMixin,
        SingleTickerProviderStateMixin,
        LoadingOverlayMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  // Bouncing Animation
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 1).animate(controller);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isHide = ValueNotifier<bool>(true);
  final capital = ValueNotifier<bool>(false);
  final number = ValueNotifier<bool>(false);
  final isNotEmpty = ValueNotifier<bool>(false);
  final special = ValueNotifier<bool>(false);
  final chacterLength = ValueNotifier<bool>(false);
  final enabled = ValueNotifier<bool>(false);
  final isConfirmHide = ValueNotifier<bool>(true);
  final isSwitched = ValueNotifier<bool>(false);
  OverlayEntry? _overlayEntry;

  final passwordMatch = ValueNotifier<bool>(false);
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordController.addListener(_checkChanged);
    _confirmPasswordController.addListener(_checkChangedConfrim);

    super.initState();
  }

  _checkChangedConfrim() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text;
      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;
    });
  }

  _checkChanged() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text;
      capital.value = _passwordController.text.contains(RegExp(r'[A-Z]'));
      number.value = _passwordController.text.contains(RegExp(r'[0-9]'));

      special.value =
          _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      chacterLength.value = _passwordController.text.length >= 8;

      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;

      isNotEmpty.value = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size(context.screenWidth(), 60),
      //     child: const DeFiRaiseAppBar(
      //       title: '',
      //     )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalMargin(20),
                Text(AppTexts.password,
                    style: Config.h2(context).copyWith(
                      fontSize: 24,
                    )),
                // 📝 Note: The code below is the same as the one in the previous snippet.
                Text(AppTexts.passwordText,
                    style: Config.b3(context).copyWith(
                      color: AppColors.grey100,
                    )),
                VerticalMargin(50),
                AppTextField(
                  hintText: AppTexts.password,
                  controller: _passwordController,
                  obscureText: isHide.value,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
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
                          isHide.value ? AppIcons.eye : AppIcons.eyeSplash,
                          color: AppColors.grey100,
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalMargin(10),
                AppTextField(
                  hintText: AppTexts.confirmPassword,
                  controller: _confirmPasswordController,
                  obscureText: isConfirmHide.value,
                  inputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConfirmHide.value = !isConfirmHide.value;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SvgPicture.asset(
                          isConfirmHide.value
                              ? AppIcons.eye
                              : AppIcons.eyeSplash,
                          color: AppColors.grey100,
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalMargin(20),
                // AnimatedOpacity of the password checker
                AnimatedContainer(
                  height: !enabled.value ? 150 : 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: AnimatedOpacity(
                    opacity: isNotEmpty.value ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    child: _passwordChecker(
                      isCapital: capital.value,
                      isNumber: number.value,
                      isSpecial: special.value,
                      isPasswordMatch: passwordMatch.value,
                      isChacterLength: chacterLength.value,
                      enabled: enabled.value,
                    ),
                  ),
                ),
                BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
                  listener: _listener,
                  builder: (context, state) {
                    return AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget? child) {
                          return AnimatedOpacity(
                            opacity: enabled.value ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: AppButton(
                              text: AppTexts.looksGood,
                              isActive: enabled.value,
                              onTap: () {
                                _passwordNode.unfocus();
                                _confirmPasswordNode.unfocus();
                                //FIXME: Navigate to login screen

                                context
                                    .read<CreatePasswordBloc>()
                                    .add(CreatePasswordEq(
                                      biometrics: isSwitched.value,
                                      username: widget.username,
                                      password: _passwordController.text,
                                    ));
                              },
                              textColor: AppColors.white100,
                              textSize: 12,
                              color: AppColors.primaryColor,
                            ),
                          );
                        });
                  },
                ),

                // Use Biometrics with switch
                VerticalMargin(10),
                AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget? child) {
                      return AnimatedOpacity(
                        opacity: enabled.value ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppTexts.useBiometrics,
                                style: Config.b3(context).copyWith(
                                  color: AppColors.grey100,
                                )),
                            Config.isAndroid
                                ? Switch(
                                    value: isSwitched.value,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched.value = value;
                                      });
                                    },
                                    activeTrackColor: AppColors.primaryColor,
                                    activeColor: AppColors.white100,
                                  )
                                : CupertinoSwitch(
                                    // This bool value toggles the switch.
                                    value: isSwitched.value,
                                    activeColor: AppColors.secondaryColor,
                                    onChanged: (bool? value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                        isSwitched.value = value ?? false;
                                      });
                                    },
                                  ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _listener(BuildContext context, CreatePasswordState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, creatingPassword: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, createPasswordError: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, createPasswordSuccess: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: "Account Created Successfully!",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
      context.goNamed(RouteConstants.login);
    });
  }

  Container _passwordChecker(
      {required bool isCapital,
      required bool isNumber,
      required bool isSpecial,
      required bool isChacterLength,
      required bool isPasswordMatch,
      required bool enabled}) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.textfieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(children: [
        _passwordCheckerItem(
          enabled: isCapital,
          text: AppTexts.capitalLetter,
        ),
        _passwordCheckerItem(
          enabled: isNumber,
          text: AppTexts.number,
        ),
        _passwordCheckerItem(
          enabled: isSpecial,
          text: AppTexts.specialCharacter,
        ),
        _passwordCheckerItem(
          enabled: isChacterLength,
          text: AppTexts.chacterLength,
        ),
        _passwordCheckerItem(
          enabled: isPasswordMatch,
          text: AppTexts.passwordNotMatch,
        ),
      ]),
    );
  }

  _passwordCheckerItem({required bool enabled, required String text}) {
    return AnimatedContainer(
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 500),
      child: Row(
        children: [
          Center(
            child: SvgPicture.asset(
              enabled ? AppIcons.success : AppIcons.error,
              color: enabled ? AppColors.successColor : AppColors.errorColor,
              height: 12,
              width: 12,
            ),
          ),
          HorizontalMargin(5),
          Text(text,
              style: Config.b3(context).copyWith(
                color: enabled ? AppColors.grey100 : AppColors.errorColor,
              )),
        ],
      ),
    );
  }
}

// Future<List<T>> removeNullable<T>(Iterable<T?> iterable) async {
//   return iterable.where((item) => item != null).cast<T>().toList();
// }

// //? Provide an issue relating to presentation-efficiency issue for the following code:
// //! Issue Rendering the ListView 
// //! The main problem is that the map function creates a new Text widget for each name in the list, 
// //!regardless of whether the names have changed or not. 
// //! This can be computationally expensive and may result in unnecessary widget rebuilding.
// //! Also using toList causes all the to be evaluated and stored to the list all at once. 
// //! This can be problematic when storing a large list of data 

// class NamesList extends StatelessWidget {
//   const NamesList({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: Repository().getNames().map(Text.new).toList(),
//     );
//   }
// }

// abstract class Repository {
//   factory Repository() => RepositoryImpl();
//   Iterable<String> getNames();
// }

// //* To Address the Issue a better solution will to use a ListView.Builder were the texts are generated and 
// //* rendered based on the index of the item 


// class NamesListSolution extends StatelessWidget {
//   const NamesListSolution({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: Repository().getNames().length,
//       itemBuilder: (BuildContext context, int index) {
//         final name = Repository().getNames().elementAt(index);
//         return Text(name);
//       },
//     );
//   }
// }
