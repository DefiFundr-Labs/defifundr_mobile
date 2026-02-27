import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/keyboard/keypad.dart';
import 'package:defifundr_mobile/core/shared/shared_services/heptics/heptic_manager.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/widget/pin_input_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ConfirmNewPinCodeScreen extends StatefulWidget {
  final String newPin;

  const ConfirmNewPinCodeScreen({super.key, required this.newPin});

  @override
  State<ConfirmNewPinCodeScreen> createState() =>
      _ConfirmNewPinCodeScreenState();
}

class _ConfirmNewPinCodeScreenState extends State<ConfirmNewPinCodeScreen>
    with TickerProviderStateMixin {
  static const int _pinLength = 4;

  final List<String> _pin = [];
  bool _showError = false;
  String _errorMessage = '';

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onNumberPressed(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(number);
        _showError = false;
      });
      HapticManager.lightImpact();

      if (_pin.length == _pinLength) {
        Future.delayed(const Duration(milliseconds: 100), _verifyPin);
      }
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
        _showError = false;
      });
      HapticManager.lightImpact();
    }
  }

  void _verifyPin() {
    if (!mounted) return;
    if (_pin.join() == widget.newPin) {
      // PIN confirmed — pop back to More screen (PIN updated)
      context.router.popUntilRoot();
    } else {
      HapticManager.heavyImpact();
      setState(() {
        _showError = true;
        _errorMessage = context.l10n.pinsDoNotMatch;
      });
      _shakeController.forward().then((_) => _shakeController.reset());
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _pin.clear();
            _showError = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      context.l10n.confirmNewPINCode,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.confirmNewPINCodeSubtitle,
                      style:
                          context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    PinInputSection(
                      pinLength: _pinLength,
                      currentPinLength: _pin.length,
                      showError: _showError,
                      errorMessage: _errorMessage,
                      shakeAnimation: _shakeAnimation,
                    ),
                    const Spacer(),
                    Keypad(
                      onNumberPressed: _onNumberPressed,
                      onBackspacePressed: _onBackspacePressed,
                      onBiometricPressed: () {},
                      biometricType: BiometricType.none,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.arrowBack,
            colorFilter:
                ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }
}
