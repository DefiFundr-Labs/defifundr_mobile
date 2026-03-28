import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A row that displays a value with a trailing copy-to-clipboard button.
///
/// Copies [value] to the clipboard on tap and shows an [AppSnackbar] confirmation.
/// Use this for wallet addresses, private keys, reference numbers, etc.
///
/// ```dart
/// // Inline (e.g. inside a card)
/// AppCopyableRow(value: walletAddress)
///
/// // Standalone card with explicit label
/// AppCopyableRow(
///   value: walletAddress,
///   label: 'Wallet address',
///   confirmationMessage: 'Address copied',
/// )
///
/// // Compact — just the value + icon, no container
/// AppCopyableRow(
///   value: privateKey,
///   confirmationMessage: context.l10n.privateKeyCopiedToClipboard,
///   showContainer: false,
/// )
/// ```
class AppCopyableRow extends StatelessWidget {
  const AppCopyableRow({
    super.key,
    required this.value,
    this.label,
    this.confirmationMessage,
    this.showContainer = true,
    this.maxLines,
  });

  /// The text value to display and copy.
  final String value;

  /// Optional label displayed above the value (only shown when [showContainer] is true).
  final String? label;

  /// Snackbar message shown after copying. Defaults to `'Copied to clipboard'`.
  final String? confirmationMessage;

  /// Whether to wrap the row in a rounded card container. Defaults to `true`.
  final bool showContainer;

  /// Maximum lines for the value text. Defaults to no limit.
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            value,
            style: fonts.textMdRegular.copyWith(
              color: colors.textSecondary,
              height: 1.6,
            ),
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () => _copy(context),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: SvgPicture.asset(
              Assets.icons.copy,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                colors.textTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );

    if (!showContainer) return row;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: fonts.textSmMedium.copyWith(
                color: colors.textTertiary,
              ),
            ),
            SizedBox(height: 4.h),
          ],
          row,
        ],
      ),
    );
  }

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    AppSnackbar.show(
      context,
      confirmationMessage ?? 'Copied to clipboard',
    );
  }
}
