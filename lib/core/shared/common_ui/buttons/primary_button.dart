import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/shared_services/heptics/heptic_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    this.color,
    required this.text,
    this.isEnabled = true, // TODO: CHANGE THIS BACK TO FALSE
    this.gradient,
    this.icon,
    this.iconRtr,
    this.textColor,
    this.textSize = 14,
    this.borderColor,
    this.fixedSize,
    this.padding,
    required this.onPressed,
    this.borderRadius,
    this.hapticFeedback,
    this.enableShake = true,
    this.enableShine = true,
  });

  final Color? color;
  final String text;
  final bool? isEnabled;
  final String? icon;
  final String? iconRtr;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final bool? gradient;
  final Size? fixedSize;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Function? hapticFeedback;
  final bool enableShake;
  final bool enableShine;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shineController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );

    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    final spring = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(spring);

    _shineAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shineController,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  Future<void> _triggerSpringEffect() async {
    if (widget.enableShake) {
      await _scaleController.forward();
      await _scaleController.reverse();
    }
  }

  Future<void> _triggerShineEffect() async {
    if (widget.enableShine && (widget.isEnabled ?? true)) {
      _shineController.reset();
      await _shineController.forward();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled == true
          ? () async {
              if (widget.hapticFeedback != null) {
                widget.hapticFeedback!();
              }
              HapticManager.lightImpact();
              _triggerSpringEffect();
              _triggerShineEffect();

              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.unfocus();
              }
              if (widget.onPressed != null) {
                widget.onPressed?.call();
              }
            }
          : null,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _shineAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: widget.isEnabled ?? true
                        ? widget.color ?? context.theme.colors.brandDefault
                        : context.theme.colors.graySecondary.withAlpha(100),
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(200.sp),
                    border: Border.all(
                      color: widget.isEnabled ?? false
                          ? widget.borderColor ?? Colors.transparent
                          : Colors.transparent,
                    ),
                  ),
                  padding: widget.padding ??
                      EdgeInsets.symmetric(
                        vertical: 10.sp,
                      ),
                  height: widget.fixedSize?.height ?? 55.h,
                  width: widget.fixedSize?.width ?? context.screenWidth() - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        SvgPicture.asset(
                          widget.icon ?? '',
                          height: 24.sp,
                          width: 24.sp,
                        )
                      else
                        const SizedBox(),
                      10.horizontalSpace,
                      Text(
                        widget.text,
                        style: context.theme.fonts.bodyMedium.copyWith(
                          fontSize: widget.textSize,
                          fontWeight: FontWeight.w600,
                          color: widget.textColor ??
                              context.theme.colors.contrastWhite,
                        ),
                      ),
                      7.horizontalSpace,
                      if (widget.iconRtr != null)
                        SvgPicture.asset(
                          widget.iconRtr ?? '',
                          height: 24.sp,
                          width: 24.sp,
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                ),
                if (widget.enableShine && (widget.isEnabled ?? true))
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(200.sp),
                      child: AnimatedBuilder(
                        animation: _shineAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              _shineAnimation.value *
                                  (context.screenWidth() + 100),
                              _shineAnimation.value * 15,
                            ),
                            child: Transform.rotate(
                              angle: -0.9,
                              child: Container(
                                width: 10,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.transparent,
                                      context.theme.colors.bgB0.withAlpha(20),
                                      context.theme.colors.bgB0.withAlpha(50),
                                      context.theme.colors.bgB0.withAlpha(20),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                // Second diagonal shine overlay (delayed and slightly offset)
                if (widget.enableShine && (widget.isEnabled ?? true))
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(200.sp),
                      child: AnimatedBuilder(
                        animation: _shineAnimation,
                        builder: (context, child) {
                          double delayedProgress =
                              (_shineAnimation.value + 0.2).clamp(-1.0, 1.0);

                          return Transform.translate(
                            offset: Offset(
                              delayedProgress * (context.screenWidth() + 100),
                              delayedProgress * 12,
                            ),
                            child: Transform.rotate(
                              angle: -0.9,
                              child: Container(
                                width: 10,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.transparent,
                                      context.theme.colors.bgB0.withAlpha(15),
                                      context.theme.colors.bgB0.withAlpha(40),
                                      context.theme.colors.bgB0.withAlpha(15),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
