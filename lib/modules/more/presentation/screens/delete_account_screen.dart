// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final List<String> _reasons = [
    'I no longer need your service',
    "I'm not satisfied with the service",
    'I switched to a different platform',
    'Other (Please specify)',
  ];

  final Set<int> _selectedReasons = {};
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
        title: Text(
          'Delete account',
          style: fonts.textLgSemiBold.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWarningBanner(context, colors, fonts),
                    SizedBox(height: 24.h),
                    Text(
                      'Please tell us why have you decided to delete your account?',
                      style: fonts.textBaseSemiBold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildReasonsList(context, colors, fonts, isLightMode),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _commentsController,
                      hintText:
                          'Would you like to leave any suggestions or comments?',
                      maxLine: 6,
                      validate: false,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: 'Delete account',
                color: colors.redDefault,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningBanner(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.redDefault.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.redDefault.withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colors.redDefault,
            size: 24.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBullet(
                  context,
                  'Deleting your account is irreversible.',
                  colors,
                  fonts,
                ),
                SizedBox(height: 4.h),
                _buildBullet(
                  context,
                  'You will lose all accumulated data but retain account access.',
                  colors,
                  fonts,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(
    BuildContext context,
    String text,
    dynamic colors,
    dynamic fonts,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: fonts.textBaseRegular.copyWith(color: colors.textPrimary),
        ),
        Expanded(
          child: Text(
            text,
            style: fonts.textBaseRegular.copyWith(color: colors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildReasonsList(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
    bool isLightMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: List.generate(_reasons.length, (index) {
          final isSelected = _selectedReasons.contains(index);
          final isLast = index == _reasons.length - 1;

          return Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedReasons.remove(index);
                    } else {
                      _selectedReasons.add(index);
                    }
                  });
                },
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? Radius.circular(16.r) : Radius.zero,
                  bottom: isLast ? Radius.circular(16.r) : Radius.zero,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _reasons[index],
                          style: fonts.textBaseMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedReasons.add(index);
                              } else {
                                _selectedReasons.remove(index);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          side: BorderSide(
                            color: colors.textTertiary,
                            width: 1.5,
                          ),
                          activeColor: colors.brandDefault,
                          checkColor: colors.contrastWhite,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 16.w,
                  endIndent: 16.w,
                  color: colors.bgB2,
                ),
            ],
          );
        }),
      ),
    );
  }
}
