// ignore_for_file: unused_element
// This file is for documentation purposes only — not imported anywhere.

import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Domain entity
// ─────────────────────────────────────────────────────────────────────────────

class Balance {
  const Balance({required this.amount, required this.currency});
  final double amount;
  final String currency;

  factory Balance.fromJson(dynamic json) => Balance(
        amount: (json as Map<String, dynamic>)['amount'] as double,
        currency: json['currency'] as String,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Repository
// ─────────────────────────────────────────────────────────────────────────────

class BalanceRepository {
  TaskEither<Failure, Balance> getBalance(String userId) =>
      AppCache.prefs.fetchTE(
        'balance_$userId',
        () => _fetchFromApi(userId),
        ttl: const Duration(minutes: 1),
        policy: CachePolicy.cacheFirst,
        retryPolicy: RetryPolicy.exponentialBackoff(maxAttempts: 3),
        fromJson: Balance.fromJson,
        toFailure: (e) => ServerFailure(message: e.toString()),
      );

  Future<Balance> _fetchFromApi(String userId) async =>
      const Balance(amount: 4250.00, currency: 'USDC');
}

// ─────────────────────────────────────────────────────────────────────────────
// BLoC
// ─────────────────────────────────────────────────────────────────────────────

sealed class BalanceEvent {}
class _LoadBalance extends BalanceEvent {}
class _BalanceUpdated extends BalanceEvent {
  _BalanceUpdated(this.balance);
  final Balance balance;
}

sealed class BalanceState {}
class BalanceInitial extends BalanceState {}
class BalanceLoading extends BalanceState {}
class BalanceLoaded extends BalanceState {
  BalanceLoaded(this.balance);
  final Balance balance;
}
class BalanceError extends BalanceState {
  BalanceError(this.failure);
  final Failure failure;
}

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> with EventBusScope {
  BalanceBloc(this._repo, this._userId) : super(BalanceInitial()) {
    on<_LoadBalance>((_, emit) async {
      emit(BalanceLoading());

      final result = await _repo.getBalance(_userId).run();

      // fold: left = failure, right = success — no try/catch
      result.fold(
        (failure) => emit(BalanceError(failure)),
        (balance) => emit(BalanceLoaded(balance)),
      );
    });

    on<_BalanceUpdated>((event, emit) {
      // Fresh data arrived while screen is open — update in place silently.
      emit(BalanceLoaded(event.balance));
    });

    // Screen is open → TTL expires → background fetch completes →
    // CacheUpdated fires → BLoC catches it → UI updates live.
    listenTo<CacheUpdated>((e) {
      if (e.key == 'balance_$_userId') {
        add(_BalanceUpdated(e.data as Balance));
      }
    });

    // Also react to revalidation failures — show stale warning.
    listenTo<CacheRevalidationFailed>((e) {
      if (e.key == 'balance_$_userId') {
        // Keep current data on screen, surface a subtle warning.
      }
    });

    add(_LoadBalance());
  }

  final BalanceRepository _repo;
  final String _userId;

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen
//
// Timeline when screen is already open:
//
//   t=0s   User opens screen
//          → BLoC calls getBalance() via TaskEither
//          → cache hit → fold → BalanceLoaded(4250.00)
//          → UI shows $4250.00 USDC instantly
//
//   t=60s  TTL expires → background fetch fires
//          → API returns 4310.50
//          → CacheUpdated<Balance> emitted on EventBus
//          → BLoC listenTo catches it → BalanceLoaded(4310.50)
//          → UI updates live — user sees balance change
//
//   Network fails during background fetch:
//          → retries 3x with exponential backoff
//          → CacheRevalidationFailed emitted
//          → BLoC can show "last updated X mins ago"
// ─────────────────────────────────────────────────────────────────────────────

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BalanceBloc(BalanceRepository(), userId),
      child: BlocBuilder<BalanceBloc, BalanceState>(
        builder: (context, state) {
          return switch (state) {
            BalanceInitial() => const SizedBox.shrink(),
            BalanceLoading() => const CircularProgressIndicator(),
            BalanceLoaded(:final balance) => Text(
                '${balance.amount} ${balance.currency}',
              ),
            BalanceError(:final failure) => Text(failure.message),
          };
        },
      ),
    );
  }
}
