// navigator.dart

import 'package:flutter/widgets.dart' show Navigator, RouteSettings;

/// RoutingContext implementation with [RouteSettings] and [Navigator].
class NavigatorContext {
  final RouteSettings routeSetings;
  final Navigator navigator;

  const NavigatorContext({
    required this.routeSetings,
    required this.navigator,
  });
}
