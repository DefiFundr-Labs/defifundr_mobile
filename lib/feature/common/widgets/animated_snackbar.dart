import 'package:flutter/material.dart';

import '../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../models/snackbar_data_model.dart';

class AnimatedSnackbar extends StatefulWidget {
  final SnackbarData _snackbarData;
  const AnimatedSnackbar({required SnackbarData snackbarData, super.key}) : _snackbarData = snackbarData;

  @override
  State<AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<AnimatedSnackbar> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  late final _slideAnimation =
      Tween<Offset>(begin: const Offset(0, -1), end: Offset(0, 1)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  Color get _backgroundColor => widget._snackbarData.isError ? Theme.of(context).colors.redFill : Theme.of(context).colors.greenFill;
  Color get _titleColor => Theme.of(context).colors.textPrimary;
  Color get _messageColor => Theme.of(context).colors.textSecondary;
  Color get _borderColor => widget._snackbarData.isError ? Theme.of(context).colors.redDefault : Theme.of(context).colors.greenDefault;

  @override
  void initState() {
    _controller.forward();
    Future.delayed(Duration(seconds: 3), _controller.reverse);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _borderColor),
        ),
        margin: EdgeInsets.only(left: 15, right: 17),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget._snackbarData.title,
              style: Theme.of(context).fonts.textBaseSemiBold.copyWith(color: _titleColor),
            ),
            Text(
              widget._snackbarData.message,
              style: Theme.of(context).fonts.textMdRegular.copyWith(color: _messageColor),
            ),
          ],
        ),
      ),
    );
  }
}
