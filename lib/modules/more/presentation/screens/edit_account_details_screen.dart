// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EditAccountDetailsScreen extends StatefulWidget {
  const EditAccountDetailsScreen({super.key});

  @override
  State<EditAccountDetailsScreen> createState() =>
      _EditAccountDetailsScreenState();
}

class _EditAccountDetailsScreenState extends State<EditAccountDetailsScreen> {
  final TextEditingController _currentEmailController = TextEditingController(
    text: 'adeshinaadegboyega@icloud.com',
  );
  final TextEditingController _newEmailController = TextEditingController(
    text: 'adeshinaadegboyega@icloud.com',
  );

  @override
  void dispose() {
    _currentEmailController.dispose();
    _newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Edit account details',
                      style: fonts.heading2Bold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Update your email to maintain account access and receive important notifications.',
                      style: fonts.textBaseRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildInfoBanner(context),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _currentEmailController,
                      labelText: 'Current email',
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      textCapitalization: TextCapitalization.none,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _newEmailController,
                      labelText: 'New email',
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      customValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: 'Save changes',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.blueFill,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.blueStroke, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: colors.blueDefault,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'i',
                style: fonts.textSmBold.copyWith(
                  color: colors.contrastWhite,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "The email you enter is what you'll use to access account.",
              style: fonts.textBaseRegular.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
