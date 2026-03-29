import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A unified empty-state widget used when a list or section has no content.
///
/// Supports two icon modes — SVG asset path or a Material [IconData].
/// Use SVG when the empty-state graphic is a custom asset;
/// use [icon] for quick, icon-only cases.
///
/// ```dart
/// // SVG variant (preferred)
/// AppEmptyState(
///   svgPath: Assets.icons.emptyInvoice,
///   title: 'No invoices yet',
///   subtitle: 'Create your first invoice to get started.',
/// )
///
/// // Compact card variant (for use inside content sections)
/// AppEmptyState.card(
///   svgPath: Assets.icons.emptyPayments,
///   message: 'No payments found',
/// )
///
/// // With an action button
/// AppEmptyState(
///   svgPath: Assets.icons.emptyExpenses,
///   title: 'No expenses yet',
///   subtitle: 'Keep track of contract-related spending here.',
///   action: ElevatedButton(onPressed: onAdd, child: Text('Add Expense')),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.svgPath,
    this.icon,
    required this.title,
    this.subtitle,
    this.action,
    this.iconSize = 64,
  }) : _isCard = false,
       _cardMessage = null;

  /// Compact card variant — used inside scrollable sections that already have
  /// a card background. Shows only a small SVG and a single message line.
  const AppEmptyState.card({
    super.key,
    this.svgPath,
    this.icon,
    required String message,
    this.iconSize = 48,
  })  : _isCard = true,
        _cardMessage = message,
        title = '',
        subtitle = null,
        action = null;

  /// SVG asset path. Use `Assets.icons.<name>` from flutter_gen.
  /// Either [svgPath] or [icon] must be provided.
  final String? svgPath;

  /// Material icon. Used when no custom SVG is available.
  final IconData? icon;

  /// Primary headline. Not used in [AppEmptyState.card].
  final String title;

  /// Optional supporting text below the title.
  final String? subtitle;

  /// Optional action widget (e.g., a button) shown below the subtitle.
  final Widget? action;

  /// Size of the icon/SVG in dp. Defaults to `64` (full) or `48` (card).
  final double iconSize;

  final bool _isCard;
  final String? _cardMessage;

  @override
  Widget build(BuildContext context) {
    return _isCard ? _buildCard(context) : _buildFull(context);
  }

  Widget _buildFull(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(context, colors),
            SizedBox(height: 20.h),
            Text(
              title,
              style: fonts.heading3SemiBold.copyWith(
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              SizedBox(height: 24.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(context, colors),
          SizedBox(height: 8.h),
          Text(
            _cardMessage ?? '',
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, dynamic colors) {
    if (svgPath != null) {
      return SvgPicture.asset(
        svgPath!,
        width: iconSize.w,
        height: iconSize.w,
        colorFilter: ColorFilter.mode(
          colors.textTertiary.withAlpha(140),
          BlendMode.srcIn,
        ),
      );
    }
    return Icon(
      icon ?? Icons.inbox_outlined,
      size: iconSize.sp,
      color: colors.grayQuaternary,
    );
  }
}
