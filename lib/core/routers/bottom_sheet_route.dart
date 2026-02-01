import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Custom route builder for bottom sheets
Route<T> bottomSheetRouteBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return ModalBottomSheetRoute<T>(
    builder: (context) => child,
    isScrollControlled: true,
    settings: page,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
  );
}

/// Scrollable bottom sheet route builder (for full-height sheets)
Route<T> scrollableBottomSheetRouteBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return ModalBottomSheetRoute<T>(
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: child,
    ),
    isScrollControlled: true,
    showDragHandle: true,
    settings: page,
    backgroundColor: Colors.white.withAlpha(2),
    useSafeArea: true,
  );
}
