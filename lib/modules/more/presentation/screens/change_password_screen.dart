import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;

  bool _has8Chars = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasSpecial = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNewPasswordChanged(String value) {
    setState(() {
      _has8Chars = value.length >= 8;
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasLowercase = value.contains(RegExp(r'[a-z]'));
      _hasSpecial = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  bool get _isFormValid {
    return _currentPasswordController.text.isNotEmpty &&
        _has8Chars &&
        _hasNumber &&
        _hasUppercase &&
        _hasLowercase &&
        _hasSpecial &&
        _newPasswordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Change password',
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Please provide your personal details, this will be used to complete your profile.',
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildInfoCard(context),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: _currentPasswordController,
                      labelText: 'Current password',
                      hideText: _hideCurrentPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(
                            () => _hideCurrentPassword = !_hideCurrentPassword),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            _hideCurrentPassword
                                ? Assets.icons.eyeIcon
                                : Assets.icons.crossEye,
                            height: 15.sp,
                            width: 15.sp,
                            colorFilter: ColorFilter.mode(
                              colors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _newPasswordController,
                      labelText: 'New password',
                      hideText: _hideNewPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(
                            () => _hideNewPassword = !_hideNewPassword),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            _hideNewPassword
                                ? Assets.icons.eyeIcon
                                : Assets.icons.crossEye,
                            height: 15.sp,
                            width: 15.sp,
                            colorFilter: ColorFilter.mode(
                              colors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      onChanged: _onNewPasswordChanged,
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        Text(
                          'Must Contain At Least:',
                          style: fonts.textSmBold
                              .copyWith(color: colors.textSecondary),
                        ),
                        _buildRequirementChip(
                            context, '8 characters', _has8Chars),
                        _buildRequirementChip(
                            context, 'A number', _hasNumber),
                        _buildRequirementChip(
                            context, 'An uppercase letter', _hasUppercase),
                        _buildRequirementChip(
                            context, 'A lowercase letter', _hasLowercase),
                        _buildRequirementChip(
                            context, 'A special character', _hasSpecial),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm new password',
                      hideText: _hideConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() =>
                            _hideConfirmPassword = !_hideConfirmPassword),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            _hideConfirmPassword
                                ? Assets.icons.eyeIcon
                                : Assets.icons.crossEye,
                            height: 15.sp,
                            width: 15.sp,
                            colorFilter: ColorFilter.mode(
                              colors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: PrimaryButton(
                text: 'Save changes',
                isEnabled: _isFormValid,
                onPressed: _isFormValid
                    ? () => context.router.maybePop()
                    : null,
              ),
            ),
            if (MediaQuery.viewInsetsOf(context).bottom < 10)
              SizedBox(
                  height: 8 + MediaQuery.systemGestureInsetsOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: IconButton(
        icon: SvgPicture.asset(
          Assets.icons.arrowBack,
          colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
          width: 24.w,
          height: 24.w,
        ),
        onPressed: () => context.router.maybePop(),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    return Container(
      decoration: BoxDecoration(
        color: colors.blueFill,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.blueStroke),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_rounded, color: colors.blueDefault, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "Your new password is what you'll use to access your account.",
              style: fonts.textSmRegular.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementChip(
      BuildContext context, String label, bool passed) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: passed ? colors.greenFill : colors.grayQuaternary,
        border: Border.all(
          color: passed ? colors.greenStroke : colors.grayTertiary,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (passed) ...[
            Icon(Icons.check, size: 14.sp, color: colors.greenDefault),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: fonts.textSmBold.copyWith(
              color: passed ? colors.greenDefault : colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
