import 'package:defifundr_mobile/core/feature_flags/app_flags.dart';

/// Compile-time flag seeds read from dart-define.
///
/// Values are compiled in via `--dart-define-from-file=config/<flavor>.json`.
/// Each key matches `FLAG_<flag_key>` in the config JSON files.
///
/// Remote flags always win — these only fill gaps when remote is unavailable.
///
/// Tier order: override → remote → dart-define seed → AppFlag.defaultValue
abstract final class FlavorFlagSeeds {
  static Map<String, dynamic> get current => {
        AppFlags.newOnboardingFlow.key: const bool.fromEnvironment(
          'FLAG_new_onboarding_flow',
          defaultValue: false,
        ),
        AppFlags.newPayrollFlow.key: const bool.fromEnvironment(
          'FLAG_new_payroll_flow',
          defaultValue: false,
        ),
        AppFlags.invoiceAttachmentsEnabled.key: const bool.fromEnvironment(
          'FLAG_invoice_attachments',
          defaultValue: false,
        ),
        AppFlags.multiWalletEnabled.key: const bool.fromEnvironment(
          'FLAG_multi_wallet',
          defaultValue: false,
        ),
        AppFlags.maxInvoiceLineItems.key: const int.fromEnvironment(
          'FLAG_max_invoice_line_items',
          defaultValue: 20,
        ),
        AppFlags.maxPayrollAmount.key: double.tryParse(
              const String.fromEnvironment('FLAG_max_payroll_amount'),
            ) ??
            100000.0,
      };
}
