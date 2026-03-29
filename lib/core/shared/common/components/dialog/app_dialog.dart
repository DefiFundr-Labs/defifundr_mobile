import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Semantic variant that controls the confirm button color in [AppDialog].
enum AppDialogVariant {
  /// Confirm button uses brand color — standard actions.
  primary,

  /// Confirm button uses red — destructive actions (delete, revoke, etc.).
  danger,
}

/// Shows a design-system-consistent modal dialog and returns the user's choice.
///
/// Returns `true` when the user confirms, `false` when they cancel,
/// and `null` if the dialog is dismissed by tapping outside.
///
/// ```dart
/// // Confirmation dialog
/// final confirmed = await AppDialog.show(
///   context,
///   title: 'Delete Account',
///   body: 'This action cannot be undone. All your data will be permanently removed.',
///   confirmLabel: 'Delete',
///   variant: AppDialogVariant.danger,
/// );
/// if (confirmed == true) cubit.deleteAccount();
///
/// // Standard confirmation
/// final confirmed = await AppDialog.show(
///   context,
///   title: 'Confirm Payment',
///   body: 'Send \$500 to John Doe?',
///   confirmLabel: 'Send',
/// );
///
/// // Info-only dialog (no cancel button)
/// await AppDialog.show(
///   context,
///   title: 'Session Expired',
///   body: 'Please log in again to continue.',
///   confirmLabel: 'OK',
///   showCancel: false,
/// );
/// ```
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.body,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    this.variant = AppDialogVariant.primary,
    this.showCancel = true,
    this.icon,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final String cancelLabel;
  final AppDialogVariant variant;
  final bool showCancel;

  /// Optional widget shown above the title — e.g. an [AppCircleIconBadge].
  final Widget? icon;

  /// Convenience method to push the dialog and await the result.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    AppDialogVariant variant = AppDialogVariant.primary,
    bool showCancel = true,
    Widget? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AppDialog(
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        variant: variant,
        showCancel: showCancel,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Dialog(
      backgroundColor: colors.bgB0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(height: 16.h),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: fonts.textLgBold.copyWith(color: colors.textPrimary),
            ),
            SizedBox(height: 8.h),
            Text(
              body,
              textAlign: TextAlign.center,
              style: fonts.textMdRegular.copyWith(color: colors.textSecondary),
            ),
            SizedBox(height: 24.h),
            PrimaryButton(
              text: confirmLabel,
              isEnabled: true,
              color: variant == AppDialogVariant.danger
                  ? colors.redDefault
                  : null,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            if (showCancel) ...[
              SizedBox(height: 10.h),
              SecondaryButton(
                text: cancelLabel,
                isEnabled: true,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
