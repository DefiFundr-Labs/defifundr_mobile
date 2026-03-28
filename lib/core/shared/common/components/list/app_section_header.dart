import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A section header row.
///
/// Renders a title on the left and an optional "See all" link on the right.
/// Used at the top of content sections (payments, contracts, expenses, etc.).
///
/// ```dart
/// // Title only
/// AppSectionHeader(title: 'Recent Payments')
///
/// // With "See all" action
/// AppSectionHeader(
///   title: 'Recent Payments',
///   onSeeAll: () => context.router.push(const PaymentsRoute()),
/// )
///
/// // Custom action label
/// AppSectionHeader(
///   title: 'Invoices',
///   seeAllLabel: 'View all',
///   onSeeAll: onViewAll,
/// )
/// ```
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.seeAllLabel = 'See all',
  });

  final String title;

  /// Callback for the "See all" button. If `null`, the button is hidden.
  final VoidCallback? onSeeAll;

  /// Label for the trailing action button. Defaults to `'See all'`.
  final String seeAllLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: fonts.textMdSemiBold.copyWith(
            color: colors.textPrimary,
          ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(4.sp),
              splashFactory: NoSplash.splashFactory,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  seeAllLabel,
                  style: fonts.textSmSemiBold.copyWith(
                    color: colors.brandDefault,
                  ),
                ),
                SizedBox(width: 2.w),
                SvgPicture.asset(
                  Assets.icons.caretRightSvg,
                  height: 13.h,
                  width: 12.w,
                  colorFilter: ColorFilter.mode(
                    colors.brandDefault,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
