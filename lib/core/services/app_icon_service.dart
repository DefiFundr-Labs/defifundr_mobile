import 'dart:io';

import 'package:flutter/services.dart';

class AppIconService {
  static const _channel = MethodChannel('com.defifundr.app/app_icon');

  // iOS alternate icon names — null means the default app icon
  static const List<String?> _iosIconNames = [
    null,
    'AppIcon1',
    'AppIcon2',
    'AppIcon3',
    'AppIcon4',
    'AppIcon5',
  ];

  // Android activity alias names — 'MainActivity' restores the default icon
  static const List<String> _androidIconNames = [
    'MainActivity',
    'icon_1',
    'icon_2',
    'icon_3',
    'icon_4',
    'icon_5',
  ];

  static const List<String> _allAndroidIcons = [
    'icon_1',
    'icon_2',
    'icon_3',
    'icon_4',
    'icon_5',
    'MainActivity',
  ];

  static Future<bool> get supportsAlternateIcons async {
    try {
      return await _channel.invokeMethod<bool>('supportsAlternateIcons') ??
          false;
    } on PlatformException {
      return false;
    }
  }

  static Future<void> setIconByIndex(int index) async {
    if (Platform.isIOS) {
      await _channel.invokeMethod<void>(
        'setAlternateIconName',
        _iosIconNames[index],
      );
    } else if (Platform.isAndroid) {
      await _channel.invokeMethod<void>('setIcon', {
        'icon': _androidIconNames[index],
        'listAvailableIcon': _allAndroidIcons,
      });
    }
  }
}
