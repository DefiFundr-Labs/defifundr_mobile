// 🐦 Flutter imports:

import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 🌎 Project imports:

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final String label;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool? readOnly;
  final void Function()? onTap;
  final Color? fillColor;

  const AppTextField(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.suffixIcon,
      this.inputType,
      this.textCapitalization = TextCapitalization.none,
      this.onChanged,
      this.onEditingComplete,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.label = '',
      this.maxLines = 1,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.enableInteractiveSelection = true,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.enabled = true,
      this.onFieldSubmitted,
      this.textInputAction,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          onSaved: onSaved,
          onEditingComplete: onEditingComplete,
          cursorColor: AppColors.grey100.withOpacity(0.5),
          obscureText: obscureText!,
          enableInteractiveSelection: enableInteractiveSelection,
          maxLines: maxLines,
          readOnly: readOnly!,
          focusNode: focusNode,
          enableIMEPersonalizedLearning: true,
          enableSuggestions: true,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          obscuringCharacter: '*',
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          keyboardType: inputType,
          textAlign: textAlign,
          textInputAction: textInputAction,
          enabled: enabled,
          style: Config.b2(context).copyWith(
            color: AppColors.primaryColor,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            fillColor: fillColor ?? AppColors.textfieldColor,
            focusColor: AppColors.white100,
            filled: true,
            label: Text(
              hintText!,
              style: Config.b3(context).copyWith(
                color: AppColors.grey100.withAlpha(100),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: AppColors.grey200.withOpacity(0.5),
                width: 1.sp,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: AppColors.grey200.withOpacity(0.5),
                width: 1.sp,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: AppColors.errorColor,
                width: 1.sp,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: AppColors.white100,
                width: 1.sp,
              ),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: labelText,
            hintText: label == '' ? 'Enter $hintText' : '$hintText',
            hintStyle: Config.b3(context).copyWith(
              color: AppColors.grey100.withAlpha(100),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
          onTap: onTap,
        ),
      ],
    );
  }
}
