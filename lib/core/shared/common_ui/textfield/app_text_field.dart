// 🎯 Dart imports:
import 'dart:async';

import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/custom_input_border.dart';
// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required TextEditingController controller,
    this.initialValue,
    this.bgColour,
    this.keyboardType,
    this.labelText,
    this.textColor,
    this.hintText,
    this.prefixType = PrefixType.none,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixType = SuffixType.none,
    this.suffixIcon,
    this.suffixWidget,
    @Deprecated(
        'Use [errorTextOnValidation] instead, or use [customValidator] to setup an alternate validator.')
    this.validator,
    this.inputFormatterType = InputFormatterType.none,
    this.inputFormatters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.readOnly = false,
    this.onTap,
    this.errorTextOnValidation = 'Field required',
    this.customValidator,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validate = true,
    this.borderRadius = 16,
    this.focusNode,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.constraints,
    this.enabled = true,
    this.hintColor,
    this.hideText = false,
    this.maxLine = 1,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.alwaysShowLabelAndHint = false,
  })  : _controller = controller,
        super(key: key);

  /// The TextEditingController for this text field.
  ///
  /// Do not forget to dispose of the controller.
  final TextEditingController _controller;

  /// The background color of the text field.
  ///
  /// Defaults to [Colors.white].
  final Color? bgColour;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final Color? textColor;
  final String? initialValue;
  final int? maxLine;

  /// This represents the optional widget or icon to be displayed before the text field input.
  ///
  /// Defaults to [PrefixType.none], with no prefix icon or widget set.
  /// If set to [PrefixType.customIcon], the [prefixIcon] must not be null,
  /// If set to [PrefixType.customWidget], the [prefixWidget] must not be null,
  /// Other values have predefined icons.
  final PrefixType prefixType;

  /// The type of prefixIcon to be displayed on the text field.
  ///
  /// This is only displayed when [prefixType] is set to [PrefixType.customIcon].
  /// It can be any widget.
  /// Defaults to null.
  final Widget? prefixIcon;

  /// The prefix to be displayed on the text field.
  ///
  /// This is only displayed when [prefixType] is set to [PrefixType.customWidget].
  /// Defaults to null.
  final Widget? prefixWidget;

  /// This represents the optional widget or icon to be displayed after the text field input.
  ///
  /// Defaults to [SuffixType.none], with no suffix icon or widget set.
  /// If set to [Suffix.customIcon], the [suffIcon] must not be null,
  /// If set to [SuffixType.customWidget], the [suffixWidget] must not be null,
  /// Other values have predefined icons.
  final SuffixType suffixType;

  /// The type of suffixIcon to be displayed on the text field.
  ///
  /// This is only displayed when [suffixType] is set to [SuffixType.customIcon].
  /// Defaults to null.
  final Widget? suffixIcon;

  /// The suffix to be displayed on the text field.
  ///
  /// This is only displayed when [suffixType] is set to [PrefixType.customWidget].
  /// Defaults to null.
  final Widget? suffixWidget;
  final String? Function(String?)? validator;

  /// This represents the optional text input formatter the text field.
  ///
  /// Defaults to [InputFormatterType.none], with no formatter set.
  /// If set to [InputFormatterType.custom], the [inputFormatters] must not be null,
  /// Other values have predefined formatters.
  final InputFormatterType inputFormatterType;

  // An optional parameter to format text field input.
  ///
  /// This is will be ignored if [inputFormatterType] is not set to [InputFormatterType.custom].
  /// Defaults to null.
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final bool readOnly;
  final void Function()? onTap;

  /// The error text to be displayed when the text field is being validated.
  ///
  /// Defaults to 'This field is required'.
  final String errorTextOnValidation;

  /// An optional parameter to validate text field input.
  ///
  /// This should only be used if the default validator is not sufficient:
  /// ```dart
  ///(value) {
  ///   if (value == null || value.isEmpty) {
  ///     return errorTextOnValidation;
  ///   }
  ///   return null;
  /// }
  /// ```
  /// This is will be ignored if [validator] is set.
  final FormFieldValidator<String>? customValidator;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  /// Whether to apply validation to the text field.
  ///
  /// Defaults to true.
  /// Note: This is ignored if [validator] is set.
  final bool validate;

  /// The border radius of the text field.
  ///
  /// Defaults to 16.
  final double borderRadius;
  final FocusNode? focusNode;

  /// The constraints to be applied to the suffix icon.
  final BoxConstraints? suffixIconConstraints;

  /// The constraints to be applied to the prefix icon.
  final BoxConstraints? prefixIconConstraints;

  /// The constraints to be applied to the text field.
  final BoxConstraints? constraints;

  /// Whether to enable the text field.
  ///
  ///  Defaults to true.

  final bool enabled;

  final Color? hintColor;

  /// The text input is replaced with large dots, to hide the actual text.
  final bool hideText;

  /// Defaults to [TextInputAction.next].
  final TextInputAction? textInputAction;

  /// Defaults to [TextCapitalization.sentences].
  final TextCapitalization textCapitalization;

  /// Whether to always show both label and hint text.
  ///
  /// When set to true, the label will be displayed above the text field
  /// and the hint will always be visible inside the text field.
  /// When set to false (default), uses the standard floating label behavior.
  ///
  /// Defaults to false.
  final bool alwaysShowLabelAndHint;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode? _focusNode;
  late final StreamController<String?> _errorTextStreamController;
  late final StreamController<bool> _alignInputToBottomController;
  late final StreamController<bool> _hasErrorController;

  @override
  void initState() {
    super.initState();
    _errorTextStreamController = StreamController<String?>.broadcast();
    _alignInputToBottomController = StreamController<bool>.broadcast();
    _hasErrorController = StreamController<bool>.broadcast();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() => _alignInput(widget.focusNode!));
      _focusNode = null;
    } else {
      _focusNode = FocusNode();
      _focusNode!.addListener(() => _alignInput(_focusNode!));
    }
  }

  void _alignInput(FocusNode focusNode) {
    if (focusNode.hasFocus || widget._controller.text.isNotEmpty) {
      _alignInputToBottomController.add(true);
    } else {
      _alignInputToBottomController.add(false);
    }
  }

  @override
  dispose() {
    _errorTextStreamController.close();
    _alignInputToBottomController.close();
    _hasErrorController.close();
    _focusNode?.dispose();
    super.dispose();
  }

  List<TextInputFormatter>? _buildInputFormatters() {
    switch (widget.inputFormatterType) {
      case InputFormatterType.phone:
        return <TextInputFormatter>[
          // FilteringTextInputFormatter.digitsOnly,
          MaskTextInputFormatter(
            mask: '#### ### ####',
            filter: {'#': RegExp(r'[0-9]')},
          ),
          LengthLimitingTextInputFormatter(11),
          // TextInputFormatter.withFunction((oldValue, newValue) {
          //   return newValue;
          // })
        ];
      case InputFormatterType.amount:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          // CurrencyTextInputFormatter(
          //   name: '',
          //   decimalDigits: 0,
          // ),
        ];
      case InputFormatterType.custom:
        if (widget.inputFormatters != null) {
          return widget.inputFormatters;
        } else {
          throw Exception(
              'inputFormatters must not be null when inputFormatterType is set to custom');
        }
      //* case InputFormatterType.none:
      default:
        return null;
    }
  }

  Widget? _buildPrefixIcon() {
    switch (widget.prefixType) {
      case PrefixType.phone:
        //! These predefined icons should be edited. These are just a placeholders.
        return const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.phone),
        );
      case PrefixType.name:
        return const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.person),
        );
      case PrefixType.customIcon:
        if (widget.prefixIcon != null) {
          return Padding(
            padding: const EdgeInsets.all(14),
            child: widget.prefixIcon!,
          );
        } else {
          throw Exception(
              'prefixIcon must not be null when prefixType is set to customIcon');
        }
      case PrefixType.customWidget:
        _buildPrefixWidget();
        return null;
      //* case PrefixType.none:
      default:
        return null;
    }
  }

  Widget? _buildPrefixWidget() {
    if (widget.prefixType == PrefixType.customWidget) {
      if (widget.prefixWidget != null) {
        return widget.prefixWidget!;
      } else {
        throw Exception(
            'prefixWidget must not be null when prefixType is set to customWidget');
      }
    } else {
      return null;
    }
  }

  Widget? _buildSuffixIcon() {
    switch (widget.suffixType) {
      case SuffixType.defaultt:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Iconsax.arrow_down_1,
              color: AppColors.grayTertiary,
              size: 14,
            ),
          ),
        );
      case SuffixType.customIcon:
        if (widget.suffixIcon != null) {
          return widget.suffixIcon;
        } else {
          throw Exception(
              'sufixIcon must not be null when suffixType is set to customIcon');
        }
      case SuffixType.customWidget:
        _buildSuffixWidget();
        return null;
      //* case SuffixType.none:
      default:
        return null;
    }
  }

  Widget? _buildSuffixWidget() {
    if (widget.suffixType == SuffixType.customWidget) {
      if (widget.suffixWidget != null) {
        return widget.suffixWidget!;
      } else {
        throw Exception(
            'suffixWidget must not be null when suffixType is set to customWidget');
      }
    } else {
      return null;
    }
  }

  String? _val(String? value) {
    bool hasError = false;
    String? errorMessage;

    if (widget.customValidator != null) {
      errorMessage = widget.customValidator!(value);
      hasError = errorMessage != null;
    } else if (widget.validate && (value == null || value.isEmpty)) {
      errorMessage = widget.errorTextOnValidation;
      hasError = true;
    }

    _errorTextStreamController.add(errorMessage);
    _hasErrorController.add(hasError);
    return hasError ? errorMessage : null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Build the text field with conditional layout
    Widget textField = _buildTextField(context, isDark);

    // If alwaysShowLabelAndHint is true, wrap with a column that includes the label
    if (widget.alwaysShowLabelAndHint && widget.labelText != null) {
      textField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Always visible label
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 14.sp,
                color: context.theme.colors.graySecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          textField,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        textField,
        StreamBuilder<String?>(
          stream: _errorTextStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null && widget.validate) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FractionalTranslation(
                    translation: widget.customValidator != null
                        ? const Offset(0, 0.2)
                        : const Offset(0, 0.1),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        snapshot.data!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.theme.colors.redDefault,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, bool isDark) {
    return StreamBuilder<bool>(
      stream: _hasErrorController.stream,
      initialData: false,
      builder: (context, errorSnapshot) {
        final hasError = errorSnapshot.data ?? false;

        return Focus(
          focusNode: _focusNode,
          child: TextFormField(
            initialValue: widget.initialValue,
            textCapitalization: widget.textCapitalization,
            controller: widget._controller,
            obscureText: widget.hideText,
            obscuringCharacter: '●',
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            maxLines: widget.maxLine,
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: widget.textColor ?? context.theme.colors.textPrimary,
              fontSize: widget.hideText ? 10.sp : 12.sp,
              height: 1.3,
            ),
            textInputAction: widget.textInputAction,
            textAlignVertical: TextAlignVertical.bottom,
            enabled: widget.enabled,
            decoration: InputDecoration(
              constraints: widget.constraints ?? const BoxConstraints(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              floatingLabelStyle: context.textTheme.titleLarge?.copyWith(
                color: hasError
                    ? context.theme.colors.redDefault
                    : context.theme.colors.graySecondary,
                fontSize: 14.sp,
              ),
              errorStyle: const TextStyle(
                color: Colors.transparent,
                height: 0,
                fontSize: 0,
              ),
              // Normal state border
              border: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: context.theme.colors.brandDefault,
                  width: 1.0,
                ),
              ),
              // Error state border - RED
              errorBorder: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: context.theme.colors.redDefault,
                  width: 2.0,
                ),
              ),
              // Disabled state border
              disabledBorder: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: context.theme.colors.brandDefault,
                  width: 1.0,
                ),
              ),
              // Enabled state border
              enabledBorder: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: hasError
                      ? context.theme.colors.redDefault
                      : context.theme.colors.textTertiary,
                  width: hasError ? 1.0 : 1.0,
                ),
              ),
              // Focused state border - BLUE
              focusedBorder: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: hasError
                      ? context.theme.colors.redDefault
                      : context.theme.colors.brandDefault,
                  width: 2.0,
                ),
              ),
              // Focused error state border - RED
              focusedErrorBorder: CustomOutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                borderSide: BorderSide(
                  color: context.theme.colors.redDefault,
                  width: 2.0,
                ),
              ),
              fillColor: _getFillColor(context, isDark),
              filled: true,
              // Conditionally set label based on alwaysShowLabelAndHint
              labelText:
                  widget.alwaysShowLabelAndHint ? null : widget.labelText,
              hintText: widget.hintText,
              labelStyle: context.textTheme.labelSmall?.copyWith(
                fontSize: 12.sp,
                color: hasError
                    ? context.theme.colors.redDefault
                    : context.theme.colors.graySecondary,
              ),
              hintStyle: context.textTheme.labelSmall?.copyWith(
                fontSize: 14.sp,
                color: widget.hintColor ?? context.theme.colors.graySecondary,
              ),
              isDense: true,
              prefix: _buildPrefixWidget(),
              prefixIconConstraints: widget.prefixIconConstraints ??
                  const BoxConstraints(minWidth: 20),
              prefixIcon: widget.alwaysShowLabelAndHint
                  ? _buildPrefixIcon() // No animation when always showing label
                  : StreamBuilder<bool>(
                      stream: _alignInputToBottomController.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: snapshot.data! ? 17 : 0),
                          child: _buildPrefixIcon(),
                        );
                      },
                    ),
              suffix: _buildSuffixWidget(),
              suffixIcon: widget.alwaysShowLabelAndHint
                  ? _buildSuffixIcon() // No animation when always showing label
                  : StreamBuilder<bool>(
                      stream: _alignInputToBottomController.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: snapshot.data! ? 18 : 0),
                          child: _buildSuffixIcon(),
                        );
                      }),
              suffixIconConstraints:
                  widget.suffixIconConstraints ?? const BoxConstraints(),
            ),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validator ?? (widget.validate ? _val : null),
            autovalidateMode: widget.autovalidateMode,
            inputFormatters: _buildInputFormatters(),
          ),
        );
      },
    );
  }

  Color _getFillColor(BuildContext context, bool isDark) {
    // If custom color is provided, use it
    if (widget.bgColour != null) {
      return widget.bgColour!;
    }

    // Otherwise, use theme-based color
    return isDark ? context.theme.colors.bgB1 : context.theme.colors.bgB0;
  }
}
