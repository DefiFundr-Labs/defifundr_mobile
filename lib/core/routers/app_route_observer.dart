import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    assert(() {
      log('Route pushed: ${route.settings.name}');
      return true;
    }());
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    assert(() {
      log('Route popped: ${route.settings.name}');
      return true;
    }());
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    assert(() {
      log(
          'Route replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
      return true;
    }());
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    assert(() {
      log('Route removed: ${route.settings.name}');
      return true;
    }());
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    assert(() {
      log('Tab route initialized: ${route.name}');
      return true;
    }());
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    assert(() {
      log('Tab route changed: from ${previousRoute.name} to ${route.name}');
      return true;
    }());
  }
}
