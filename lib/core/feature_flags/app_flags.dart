import 'package:defifundr_mobile/core/feature_flags/app_flag.dart';

/// All feature flags for the app — single source of truth.
///
/// Add new flags here as `static const` fields.
/// Never reference flag keys as raw strings outside this class.
abstract final class AppFlags {
  // ── Onboarding ─────────────────────────────────────────────────────────────
  static const newOnboardingFlow =
      AppFlag<bool>('new_onboarding_flow', defaultValue: false);

  // ── Payroll ────────────────────────────────────────────────────────────────
  static const newPayrollFlow =
      AppFlag<bool>('new_payroll_flow', defaultValue: false);

  static const maxPayrollAmount =
      AppFlag<double>('max_payroll_amount', defaultValue: 100000.0);

  // ── Invoice ────────────────────────────────────────────────────────────────
  static const invoiceAttachmentsEnabled =
      AppFlag<bool>('invoice_attachments', defaultValue: false);

  static const maxInvoiceLineItems =
      AppFlag<int>('max_invoice_line_items', defaultValue: 20);

  // ── Wallet ─────────────────────────────────────────────────────────────────
  static const multiWalletEnabled =
      AppFlag<bool>('multi_wallet', defaultValue: false);

  // ── Maintenance ────────────────────────────────────────────────────────────

  /// Non-empty string = show maintenance banner with this message.
  static const maintenanceBanner =
      AppFlag<String>('maintenance_banner', defaultValue: '');

  static const forceUpdateVersion =
      AppFlag<String>('force_update_version', defaultValue: '');
}
