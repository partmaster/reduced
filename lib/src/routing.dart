/// interface for getting route data.
abstract class RoutingState {
  const RoutingState();
  String? get name;
  Map<String, String> get pathParameters;
  Map<String, String> get queryParameters;
  Map<String, List<String>> get queryParametersAll;
}

/// interface for push and pop pages via routes.
abstract class RoutingStack {
  const RoutingStack();
  Future<T?> pushNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  });
  void pushReplacementNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  });
  void pop<T>([T? value]);
}

/// RoutingContext for page props mappers.
class RoutingContext {
  const RoutingContext(this.state, this.stack);
  final RoutingState state;
  final RoutingStack stack;
}
