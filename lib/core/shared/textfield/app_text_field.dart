import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/size.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const AppTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              focusNode: widget.focusNode ?? _focusNode,
              style: Config.b2(context).copyWith(
                color: context.theme.primaryColorDark,
              ),
              obscuringCharacter: '*',
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: Config.b3(context).copyWith(
                  color: context.theme.primaryColorDark,
                ),
                filled: true,
                fillColor: Colors.transparent,
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
