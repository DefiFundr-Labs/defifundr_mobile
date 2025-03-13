import 'package:defiraiser_mobile/core/global/constants/app_images.dart';
import 'package:defiraiser_mobile/core/global/constants/app_texts.dart';
import 'package:defiraiser_mobile/core/global/constants/size.dart';
import 'package:defiraiser_mobile/core/global/themes/color_scheme.dart';
import 'package:defiraiser_mobile/core/routers/routes_constants.dart';
import 'package:defiraiser_mobile/core/shared/button/buttons.dart';
import 'package:defiraiser_mobile/core/shared/custom_tooast/custom_tooast.dart';
import 'package:defiraiser_mobile/core/utils/loading_overlay.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/login/states/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:defiraiser_mobile/features/authentication/presentation/login/states/set_profile_avatar/bloc/set_profile_avatar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectAvatarScreen extends StatefulWidget {
  const SelectAvatarScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen>
    with SingleTickerProviderStateMixin, LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isValidate = ValueNotifier<bool>(false);
  final isSelected = ValueNotifier<int>(0);
  OverlayEntry? _overlayEntry;

  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 25.sp, vertical: 30.sp),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppTexts.selectAvatar,
                                  style: Config.h2(context).copyWith(
                                    fontSize: 24.sp,
                                  )),
                              VerticalMargin(5),
                              // 📝 Note: The code below is the same as the one in the previous snippet.
                              Text(AppTexts.selectAvatarDesc,
                                  style: Config.b3(context).copyWith(
                                    color: AppColors.grey100,
                                  )),
                              VerticalMargin(20),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          return Container(
                                            width: 120.sp,
                                            // margin: EdgeInsets.all(
                                            //     _animationController.value * 3),
                                            padding: EdgeInsets.all(
                                                _animationController.value * 3),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.grey200,
                                                    width: 4.sp)),
                                            child: CircleAvatar(
                                              radius: 60.sp,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  AppImages.avatar(
                                                      isSelected.value + 1)),
                                            ),
                                          );
                                        }),
                                    Positioned(
                                      top: 0,
                                      right: -8,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.textfieldColor,
                                            border: Border.all(
                                                color: AppColors.white100,
                                                width: 3.sp)),
                                        child: CircleAvatar(
                                            radius: 15.sp,
                                            backgroundColor:
                                                AppColors.textfieldColor,
                                            child: AnimatedBuilder(
                                                animation: _animationController,
                                                builder: (context, child) {
                                                  return AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    // Change anchor point

                                                    transform:
                                                        Matrix4.rotationZ(
                                                            _animationController
                                                                    .value *
                                                                0.25),
                                                    child: Text('👋',
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: AppColors
                                                                .white100)),
                                                  );
                                                })),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              VerticalMargin(30),

                              Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  spacing: 30.sp,
                                  runSpacing: 10.sp,
                                  verticalDirection: VerticalDirection.down,
                                  children: List.generate(
                                      9, (index) => _avatars(index)),
                                ),
                              ),
                              VerticalMargin(20),
                              // Login Button
                              BlocConsumer<SetProfileAvatarBloc,
                                  SetProfileAvatarState>(
                                listener: _listener,
                                builder: (context, state) {
                                  return AppButton(
                                    text: AppTexts.dashboard,
                                    onTap: () {
                                      //FIXME: Navigate to login screen
                                      //
                                      context
                                          .read<SetProfileAvatarBloc>()
                                          .add(SetProfileAvatarEq(
                                            imageId: isSelected.value + 1,
                                          ));
                                    },
                                    textColor: AppColors.white100,
                                    textSize: 12,
                                    color: AppColors.primaryColor,
                                  );
                                },
                              ),
                            ]))))));
  }

  void _listener(BuildContext context, SetProfileAvatarState state) {
    state.maybeWhen(orElse: () {
      _overlayEntry?.remove();
    }, loading: () {
      _overlayEntry = showLoadingOverlay(context, _overlayEntry);
    }, profileError: (message) {
      _overlayEntry?.remove();
      context.showToast(
        title: message,
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: false,
      );
    }, profileSet: (response) {
      _overlayEntry?.remove();
      context.showToast(
        title: "Avatar set successfully",
        context: context,
        toastDurationInSeconds: 1,
        isSuccess: true,
      );
      context.read<GetUserDetailsBloc>().add(GetUserEventEq());
      context.goNamed(RouteConstants.home);
    });
  }

  GestureDetector _avatars(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected.value = index;
          print(isSelected.value);
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            // Ripple effect on border
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textfieldColor,
                border: Border.all(
                    color: isSelected.value == index
                        ? AppColors.secondaryColor
                        : AppColors.textfieldColor,
                    width: 1)),
            child: CircleAvatar(
              radius: 40.sp,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                AppImages.avatar(index + 1),
              ),
            ),
          ),
          VerticalMargin(5),
          Text(
            '0x0${index + 1}',
            style: Config.b3(context).copyWith(
              color: AppColors.grey100,
            ),
          )
        ],
      ),
    );
  }
}
