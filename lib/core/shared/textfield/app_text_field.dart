import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? fillColor;
  final int? maxLines;

  final bool isDropdown;
  final List<String>? dropdownItems;
  final Function(String)? onSelectItem;
  final Widget? dropDownSheetChild;
  final VoidCallback? onDropdownTap;

  const AppTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.borderRadius,
    this.border,
    this.fillColor,
    this.maxLines,
    this.isDropdown = false,
    this.dropdownItems,
    this.onSelectItem,
    this.onDropdownTap,
    this.dropDownSheetChild,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  void _showDropdownBottomSheet(BuildContext context) {
    final items = widget.dropdownItems;
    if (items == null || items.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: InkWell(
                onTap: () {
                  _controller.text = item;
                  widget.onSelectItem?.call(item);
                  Navigator.pop(context);
                },
                child: Text(
                  item,
                  style: context.theme.fonts.textMdMedium,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.focusNode ?? _focusNode,
      child: SizedBox(
        height: widget.maxLines != null && widget.maxLines! > 1 ? null : 52.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: widget.maxLines ?? 1,
              controller: _controller,
              obscureText: widget.obscureText,
              focusNode: widget.focusNode ?? _focusNode,
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              readOnly: widget.isDropdown,
              obscuringCharacter: '•',
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              onTap: widget.isDropdown
                  ? () {
                      if (widget.onDropdownTap != null) {
                        widget.onDropdownTap!();
                      } else if (widget.dropDownSheetChild != null) {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            // builder: (_) => widget.dropDownSheetChild!,
                            builder: (_) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 16),
                                    SvgPicture.asset(
                                      AppAssets.rectangleSvg,
                                      width: 48,
                                      height: 5,
                                    ),
                                    Flexible(
                                      child: widget.dropDownSheetChild!,
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        _showDropdownBottomSheet(context);
                      }
                    }
                  : null,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                ),
                filled: true,
                fillColor: widget.fillColor ?? Colors.transparent,
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: widget.maxLines != null && widget.maxLines! > 1
                      ? 8.h
                      : 2.0,
                  horizontal: 20.0,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isDropdown
                    ? Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey[600])
                    : widget.suffixIcon,
                suffix: widget.suffix,
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
            color: widget.fillColor ?? Colors.transparent,
            border: widget.border ??
                Border.all(
                  color: _focusNode.hasFocus
                      ? Colors.purple
                      : context.theme.colors.grayTertiary!,
                ),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            child: child,
          ),
        );
      },
    );
  }
}
