// navigator.dart

import 'package:flutter/widgets.dart' show NavigatorState, RouteSettings;

/// RoutingContext implementation with [RouteSettings] and [NavigatorState].
class NavigatorContext {
  final RouteSettings settings;
  final NavigatorState navigator;

  const NavigatorContext({
    required this.settings,
    required this.navigator,
  });
}
