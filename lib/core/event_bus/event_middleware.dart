import 'package:defifundr_mobile/core/event_bus/app_event.dart';

/// Return the (optionally transformed) event to continue the chain.
/// Return null to drop the event — it will not be emitted.
typedef EventMiddleware = Future<AppEvent?> Function(AppEvent event);
