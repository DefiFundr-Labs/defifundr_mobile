import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../../design_system/theme_extension/app_theme_extension.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const AppTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
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
    return ListenableBuilder(
      listenable: widget.focusNode ?? _focusNode,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              focusNode: widget.focusNode ?? _focusNode,
              style: Theme.of(context).fonts.textMdRegular,
              obscuringCharacter: '*',
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: Theme.of(context).fonts.textMdRegular.copyWith(color: Theme.of(context).colors.textTertiary),
                floatingLabelStyle: Theme.of(context).fonts.textSmRegular,
                filled: true,
                fillColor: Colors.transparent,
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colors.bgB1,
              border: Border.all(
                  color: switch ((widget.focusNode ?? _focusNode).hasFocus) {
                false => Theme.of(context).colors.strokeSecondary,
                true => Theme.of(context).colors.brandDefault,
              }),
              borderRadius: BorderRadius.circular(12)),
          child: child,
        );
      },
    );
  }
}
