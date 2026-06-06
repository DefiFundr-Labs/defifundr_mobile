import 'dart:io';

import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/feature_flags/feature_flag_service.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:defifundr_mobile/core/event_bus/app_event.dart'
    show AppUpdateRequired, AppUpdateStatus;

final _log = Logger();

/// Checks whether the running app version requires an update.
///
/// Reads [AppFlags.forceUpdateVersion] and [AppFlags.softUpdateVersion]
/// from [FeatureFlagService] and compares against the installed version.
///
/// Call [check] on app start and whenever [FlagsRefreshed] fires.
///
/// ```dart
/// final status = await AppUpdateService.instance.check();
/// ```
class AppUpdateService {
  AppUpdateService._();
  static final instance = AppUpdateService._();

  // Store URLs injected once at startup (from your config / env).
  String _appStoreUrl = '';
  String _playStoreUrl = '';

  PackageInfo? _packageInfo;

  /// Call once at startup with your store URLs.
  Future<void> init({
    required String appStoreUrl,
    required String playStoreUrl,
  }) async {
    _appStoreUrl = appStoreUrl;
    _playStoreUrl = playStoreUrl;
    _packageInfo = await PackageInfo.fromPlatform();
    _log.d('[Update] Running version: ${_packageInfo!.version}');
  }

  // ── Check ──────────────────────────────────────────────────────────────────

  /// Compare current version against flag values.
  ///
  /// Emits [AppUpdateRequired] on EventBus when an update is needed so any
  /// listener (e.g. a root BLoC) can react without being called directly.
  Future<AppUpdateStatus> check() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    final current = _parseVersion(_packageInfo!.version);

    final forceStr =
        FeatureFlagService.instance.get(AppFlags.forceUpdateVersion);
    final softStr =
        FeatureFlagService.instance.get(AppFlags.softUpdateVersion);

    // Force update takes priority.
    if (forceStr.isNotEmpty) {
      final force = _parseVersion(forceStr);
      if (_isBelow(current, force)) {
        _log.w('[Update] Force update required. current=$current min=$force');
        EventBus.instance.emit(AppUpdateRequired(
          status: AppUpdateStatus.forceUpdate,
          latestVersion: forceStr,
        ));
        return AppUpdateStatus.forceUpdate;
      }
    }

    if (softStr.isNotEmpty) {
      final soft = _parseVersion(softStr);
      if (_isBelow(current, soft)) {
        _log.i('[Update] Soft update available. current=$current latest=$soft');
        EventBus.instance.emit(AppUpdateRequired(
          status: AppUpdateStatus.softUpdate,
          latestVersion: softStr,
        ));
        return AppUpdateStatus.softUpdate;
      }
    }

    _log.d('[Update] Up to date.');
    return AppUpdateStatus.upToDate;
  }

  // ── Store launch ───────────────────────────────────────────────────────────

  Future<void> openStore() async {
    final url = Uri.parse(Platform.isIOS ? _appStoreUrl : _playStoreUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _log.e('[Update] Could not launch store URL: $url');
    }
  }

  // ── Version helpers ────────────────────────────────────────────────────────

  /// Parse "1.2.3" or "1.2.3+45" into [major, minor, patch].
  List<int> _parseVersion(String version) {
    final clean = version.split('+').first.trim();
    final parts = clean.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    while (parts.length < 3) {
      parts.add(0);
    }
    return parts;
  }

  /// True if [current] is strictly below [minimum].
  bool _isBelow(List<int> current, List<int> minimum) {
    for (var i = 0; i < 3; i++) {
      if (current[i] < minimum[i]) return true;
      if (current[i] > minimum[i]) return false;
    }
    return false; // equal
  }
}
