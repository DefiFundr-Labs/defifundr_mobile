// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:defifundr_mobile/core/feature_flags/feature_flag_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. App startup — init before runApp, refresh after login
// ─────────────────────────────────────────────────────────────────────────────

Future<void> _setupFlags() async {
  // Load last-known flags from cache — sync, no network.
  await FeatureFlagService.instance.init();
}

Future<void> _refreshFlagsAfterLogin() async {
  await FeatureFlagService.instance
      .refresh(
        // Replace with your actual API call.
        () async => {'new_payroll_flow': true, 'max_invoice_line_items': 50},
        onError: (e) => NetworkFailure(message: e.toString()),
      )
      .run();
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Reading flags — sync, zero-latency
// ─────────────────────────────────────────────────────────────────────────────

void _readingExample() {
  final flags = FeatureFlagService.instance;

  if (flags.isEnabled(AppFlags.newPayrollFlow)) {
    // show new flow
  }

  final limit = flags.get(AppFlags.maxInvoiceLineItems); // int
  final maxAmount = flags.get(AppFlags.maxPayrollAmount); // double

  if (flags.hasValue(AppFlags.maintenanceBanner)) {
    // ignore: unused_local_variable
    final message = flags.get(AppFlags.maintenanceBanner);
    // show banner with: message
  }

  // ignore: unused_local_variable
  final _ = (limit, maxAmount);
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. BLoC reacting to flag changes via EventBus
// ─────────────────────────────────────────────────────────────────────────────

sealed class _DashboardEvent {}
class _Load extends _DashboardEvent {}
class _FlagsChanged extends _DashboardEvent {}

class _DashboardState {
  const _DashboardState({
    required this.showNewPayroll,
    required this.invoiceLimit,
  });
  final bool showNewPayroll;
  final int invoiceLimit;
}

class _DashboardBloc extends Bloc<_DashboardEvent, _DashboardState>
    with EventBusScope {
  _DashboardBloc()
      : super(const _DashboardState(showNewPayroll: false, invoiceLimit: 20)) {
    on<_Load>((_, emit) => emit(_buildState()));
    on<_FlagsChanged>((_, emit) => emit(_buildState()));

    // Flags refreshed in background (e.g. after silent re-auth) → re-render.
    listenTo<FlagsRefreshed>((_) => add(_FlagsChanged()));

    add(_Load());
  }

  _DashboardState _buildState() {
    final flags = FeatureFlagService.instance;
    return _DashboardState(
      showNewPayroll: flags.isEnabled(AppFlags.newPayrollFlow),
      invoiceLimit: flags.get(AppFlags.maxInvoiceLineItems),
    );
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Widget-level gate — renders child only when flag is enabled
// ─────────────────────────────────────────────────────────────────────────────

class FlagGate extends StatelessWidget {
  const FlagGate({
    super.key,
    required this.flag,
    required this.child,
    this.fallback,
  });

  final AppFlag<bool> flag;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return FeatureFlagService.instance.isEnabled(flag)
        ? child
        : fallback ?? const SizedBox.shrink();
  }
}

// Usage in a screen:
Widget _payrollSection() => FlagGate(
      flag: AppFlags.newPayrollFlow,
      fallback: const Text('Legacy Payroll UI'),
      child: const Text('New Payroll UI'),
    );

// ─────────────────────────────────────────────────────────────────────────────
// 5. Maintenance banner — driven by a string flag
// ─────────────────────────────────────────────────────────────────────────────

class MaintenanceBanner extends StatelessWidget {
  const MaintenanceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final message = FeatureFlagService.instance.get(AppFlags.maintenanceBanner);
    if (message.isEmpty) return const SizedBox.shrink();

    return MaterialBanner(
      content: Text(message),
      actions: const [SizedBox.shrink()],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Dev overrides — flip flags without a remote change
// ─────────────────────────────────────────────────────────────────────────────

void _devOverrides() {
  final flags = FeatureFlagService.instance;

  flags.override(AppFlags.newPayrollFlow, true);
  flags.override(AppFlags.maxInvoiceLineItems, 100);

  flags.clearOverride(AppFlags.newPayrollFlow);
  flags.clearAllOverrides();
}
