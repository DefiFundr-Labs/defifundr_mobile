import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/blockchain_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockchainWalletLoader extends StatefulWidget {
  final BlockchainType blockchainType;
  final bool isVisible;
  final VoidCallback? onDismiss;

  const BlockchainWalletLoader({
    Key? key,
    required this.blockchainType,
    required this.isVisible,
    this.onDismiss,
  }) : super(key: key);

  @override
  State<BlockchainWalletLoader> createState() => _BlockchainWalletLoaderState();
}

class _BlockchainWalletLoaderState extends State<BlockchainWalletLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final blockchainName = widget.blockchainType.toString().split('.').last;
    final title = "Loading $blockchainName Wallet";
    const message = "Please wait while we fetch your wallet information...";

    return Container(
      color: Colors.black.withOpacity(0.5),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Card background
            Container(
              width: 0.9.sw,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors.bgB0,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 80.h), // Space for the animated icon
                  Text(
                    title,
                    style: fonts.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      width: double.infinity,
                      height: 8.h,
                      child: LinearProgressIndicator(
                        backgroundColor: colors.inactiveButton,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getBlockchainColor(widget.blockchainType, context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  if (widget.onDismiss != null)
                    GestureDetector(
                      onTap: widget.onDismiss,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.r),
                          border: Border.all(
                            color: colors.blueActive,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: fonts.textSmSemiBold.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Animated blockchain icon (positioned at the top of the card)
            Positioned(
              top: -40.h,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: colors.bgB0,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _getBlockchainIcon(widget.blockchainType),
                            color: _getBlockchainColor(
                                widget.blockchainType, context),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBlockchainColor(BlockchainType type, BuildContext context) {
    final colors = context.theme.colors;

    switch (type) {
      case BlockchainType.ethereum:
        return colors.activeButton;
      case BlockchainType.solana:
        return colors.activeButton;
      case BlockchainType.starknet:
        return colors.activeButton;
      default:
        return colors.activeButton;
    }
  }

  String _getBlockchainIcon(BlockchainType type) {
    switch (type) {
      case BlockchainType.ethereum:
        return AppIcons.ethereumIcon;
      case BlockchainType.solana:
        return AppIcons.appIcon;
      case BlockchainType.starknet:
        return AppIcons.stellar;
      default:
        return AppIcons.stellar;
    }
  }
}
