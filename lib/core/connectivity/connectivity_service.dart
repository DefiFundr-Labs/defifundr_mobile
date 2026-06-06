import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:defifundr_mobile/core/connectivity/operation_queue.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:logger/logger.dart';

final _log = Logger();

/// Probing targets — tried in order, first success wins.
const _probeTargets = [
  ('dns.google', 53),
  ('one.one.one.one', 53),
  ('8.8.8.8', 53),
];

const _probeTimeout = Duration(seconds: 3);
const _recheckInterval = Duration(seconds: 10);

class ConnectivityService {
  ConnectivityService._();

  static final instance = ConnectivityService._();

  final _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _networkSub;
  Timer? _pollingTimer;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  Future<void> init() async {
    // Probe immediately to get accurate initial state.
    _isOnline = await _hasInternet();

    // React to network interface changes — use as a trigger to re-probe.
    _networkSub = _connectivity.onConnectivityChanged.listen((results) {
      final hasInterface = _hasInterface(results);

      // Interface dropped — mark offline immediately without probing.
      if (!hasInterface) {
        _updateState(false);
        return;
      }

      // Interface came up — probe to confirm real internet.
      _probe();
    });

    // Poll periodically to catch silent failures (captive portals, ISP drops)
    // that don't trigger a connectivity change event.
    _pollingTimer = Timer.periodic(_recheckInterval, (_) => _probe());
  }

  Future<void> _probe() async {
    final online = await _hasInternet();
    _updateState(online);
  }

  void _updateState(bool online) {
    if (online == _isOnline) return;
    _isOnline = online;
    _log.i('[Connectivity] ${online ? 'Online' : 'Offline'}');
    EventBus.instance.emit(ConnectivityChanged(isOnline: online));
    if (online) OperationQueue.instance.drain();
  }

  /// Opens a raw TCP socket to each probe target.
  /// No HTTP overhead — just confirms the internet is routable.
  Future<bool> _hasInternet() async {
    for (final (host, port) in _probeTargets) {
      try {
        final socket = await Socket.connect(host, port, timeout: _probeTimeout);
        socket.destroy();
        return true;
      } catch (_) {
        continue;
      }
    }
    return false;
  }

  bool _hasInterface(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);

  void dispose() {
    _networkSub?.cancel();
    _pollingTimer?.cancel();
  }
}
