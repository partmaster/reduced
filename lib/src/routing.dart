/// class for getting route data.
class RoutingState {
  const RoutingState({
    this.name,
    this.pathParameters = const <String, String>{},
    this.queryParameters = const <String, String>{},
    this.queryParametersAll = const <String, List<String>>{},
  });

  final String? name;
  final Map<String, String> pathParameters;
  final Map<String, String> queryParameters;
  final Map<String, List<String>> queryParametersAll;
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
  static const nil = RoutingContext(
    RoutingState(),
    NilRoutingStack.instance,
  );

  const RoutingContext(this.state, this.stack);
  final RoutingState state;
  final RoutingStack stack;
}

class NilRoutingStack extends RoutingStack {
  const NilRoutingStack._();
  static const instance = NilRoutingStack._();
  @override
  void pop<T>([T? value]) {}

  @override
  Future<T?> pushNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      Future.value(null);

  @override
  void pushReplacementNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {}
}
