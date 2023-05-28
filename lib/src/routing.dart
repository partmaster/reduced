/// interface for getting route data.
abstract class RoutingState {
  const RoutingState();
  String? get routeName;
  Map<String, String> get pathParameters;
  Map<String, String> get queryParameters;
  Map<String, List<String>> get queryParametersAll;
}

/// interface for dispatching routes.
abstract class RoutingDispatcher {
  const RoutingDispatcher();
  Future<T?> pushNamed<T>(String routeName);
  Future<T?> pushReplacementNamed<T>(String routeName);
  void pop<T>([T? value]);
}

/// RoutingContext for page props mappers.
class RoutingContext {
  const RoutingContext(this.state, this.dispatcher);
  final RoutingState state;
  final RoutingDispatcher dispatcher;
}
