import 'package:defiraiser_mobile/core/cache/app_cache.dart';
import 'package:defiraiser_mobile/core/di/injector.dart';
import 'package:defiraiser_mobile/core/global/constants/app_icons.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/local/local.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/appbar/appbar.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/shared/textfield/textfield.dart';
import 'package:defiraiser_mobile/core/utils/input_validation.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/profile/presentation/state/get_private_key_bloc/bloc/get_private_key_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();

  OverlayEntry? _overlayEntry;
  final FocusNode _passwordNode = FocusNode();
  final isValidate = ValueNotifier<bool>(false);
  final isHide = ValueNotifier<bool>(true);
  final user = sl<AppCache>().getUserDetails();

  @override
  void initState() {
    _passwordController.addListener(_checkChanged);
    super.initState();
  }

  void _checkChanged() {
    setState(() {
      isValidate.value = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            isBack: true,
            title: "",
          ),
        ),
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
                                AppTexts.security,
                                style: Config.h2(context).copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.securityDesc,
                                  style: Config.b3(context).copyWith(
                                    color: AppColors.grey100,
                                  )),
                              VerticalMargin(50),

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
                              !user.biometrics
                                  ? SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        TextButton(
                                          onPressed: () async {
                                            sl<LocalAuth>()
                                                .hasAvailableBiometrics()
                                                .then((value) {
                                              if (value) {
                                                context
                                                    .read<GetPrivateKeyBloc>()
                                                    .add(PrivateKeyEvent(
                                                      password:
                                                          _passwordController
                                                              .text,
                                                      isBio: true,
                                                    ));
                                              } else {
                                                context.showToast(
                                                  title:
                                                      "No biometrics available",
                                                  context: context,
                                                  toastDurationInSeconds: 1,
                                                  isSuccess: false,
                                                );
                                              }
                                            });
                                          },
                                          style: ButtonStyle(
                                            overlayColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                AppTexts.useBiometrics,
                                                style:
                                                    Config.b3(context).copyWith(
                                                  fontSize: 15,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              HorizontalMargin(5),
                                              Config.isAndroid
                                                  ? SvgPicture.asset(
                                                      AppIcons.fingerPrint,
                                                      color: AppColors
                                                          .primaryColor,
                                                      height: 15,
                                                      width: 15,
                                                    )
                                                  : SvgPicture.asset(
                                                      AppIcons.faceId,
                                                      color: AppColors
                                                          .primaryColor,
                                                      height: 15,
                                                      width: 15,
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                              VerticalMargin(10),
                              // Login Button
                              BlocConsumer<GetPrivateKeyBloc,
                                      GetPrivateKeyState>(
                                  listener: _listener,
                                  builder: (context, state) {
                                    return AppButton(
                                      text: AppTexts.getPrivateKey,
                                      isActive: isValidate.value,
                                      onTap: () async {
                                        context
                                            .read<GetPrivateKeyBloc>()
                                            .add(PrivateKeyEvent(
                                              password:
                                                  _passwordController.text,
                                              isBio: false,
                                            ));
                                      },
                                      textColor: AppColors.white100,
                                      textSize: 12,
                                      color: AppColors.primaryColor,
                                    );
                                  }),

                              VerticalMargin(20),
                            ]))))));
  }

  void _listener(BuildContext context, GetPrivateKeyState state) {
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
    }, loaded: (response) {
      _overlayEntry?.remove();
      context.pushNamed(RouteConstants.privateKey, queryParameters: {
        "address": response.data.address,
        "privateKey": response.data.privateKey,
      });
    });
  }
}
