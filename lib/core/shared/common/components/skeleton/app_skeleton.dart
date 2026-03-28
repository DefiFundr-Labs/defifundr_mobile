import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A shimmering placeholder shown while content is loading.
///
/// Uses an animated gradient that sweeps left-to-right, adapting its base
/// color to the current theme (light/dark) automatically.
///
/// ```dart
/// // Inline block placeholder
/// AppSkeleton(width: 120, height: 16)
///
/// // Full-width text line
/// AppSkeleton(height: 14)
///
/// // Circle avatar placeholder
/// AppSkeleton(width: 48, height: 48, borderRadius: 24)
///
/// // Card placeholder
/// AppSkeleton(height: 80, borderRadius: 12)
/// ```
///
/// For a list of loading rows, see [AppSkeletonList].
class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  /// Width in dp. Defaults to `double.infinity` (full width).
  final double? width;

  /// Height in dp. Defaults to `16`.
  final double height;

  /// Corner radius in dp. Defaults to `8`.
  final double? borderRadius;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final baseColor =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E8E8);
    final highlightColor =
        isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Container(
          width: widget.width ?? double.infinity,
          height: widget.height.h,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular((widget.borderRadius ?? 8).r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
                (_animation.value + 0.9).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A column of [AppSkeleton] rows simulating a loading list.
///
/// ```dart
/// // 5 text-line rows
/// AppSkeletonList(count: 5)
///
/// // Custom row height and spacing
/// AppSkeletonList(count: 3, itemHeight: 60, spacing: 12)
///
/// // Card-style rows
/// AppSkeletonList(count: 4, itemHeight: 80, borderRadius: 12)
/// ```
class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({
    super.key,
    this.count = 5,
    this.itemHeight = 56,
    this.spacing = 12,
    this.borderRadius = 12,
  });

  /// Number of skeleton rows. Defaults to `5`.
  final int count;

  /// Height of each row in dp. Defaults to `56`.
  final double itemHeight;

  /// Vertical gap between rows in dp. Defaults to `12`.
  final double spacing;

  /// Corner radius for each row. Defaults to `12`.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < count - 1 ? spacing.h : 0),
          child: AppSkeleton(height: itemHeight, borderRadius: borderRadius),
        );
      }),
    );
  }
}
