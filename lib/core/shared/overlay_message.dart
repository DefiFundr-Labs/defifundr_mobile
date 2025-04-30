import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/enum_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverlayMessage extends StatefulWidget {
  final String title;
  final String message;
  final MessageType type;
  final Duration duration;
  final VoidCallback? onDismiss;

  const OverlayMessage({
    super.key,
    required this.title,
    required this.message,
    this.type = MessageType.error,
    this.duration = const Duration(seconds: 3),
    this.onDismiss,
  });

  @override
  State<OverlayMessage> createState() => _OverlayMessageState();
}

class _OverlayMessageState extends State<OverlayMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    // Auto-dismiss after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        _animationController.reverse().then((_) {
          if (widget.onDismiss != null) {
            widget.onDismiss!();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    final Color backgroundColor = widget.type == MessageType.error
        ? colors.redFill.withOpacity(0.3)
        : colors.greenFill.withOpacity(0.3);

    final Color borderColor = widget.type == MessageType.error
        ? colors.redDefault
        : colors.greenDefault;

    final Color iconColor = widget.type == MessageType.error
        ? colors.redDefault
        : colors.greenDefault;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    widget.type == MessageType.error
                        ? Icons.error_outline
                        : Icons.check_circle_outline,
                    color: iconColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: fonts.textLgBold,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.message,
                          style: fonts.textMdRegular.copyWith(
                            color: colors.textQuaternary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _animationController.reverse().then((_) {
                        if (widget.onDismiss != null) {
                          widget.onDismiss!();
                        }
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: colors.textQuaternary,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
