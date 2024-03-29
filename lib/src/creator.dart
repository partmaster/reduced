// creator.dart

/// Callable class that creates a [Future].
///
/// Type parameter R is the type parameter of the created future.
abstract class FutureCreator<R> {
  Future<R> call();
}

/// Callable class that creates a [Future] from a parameter.
///
/// Type parameter R is the type parameter of the created future.
/// Type parameter P is the type of the parameter of `call` method.
abstract class FutureCreator1<R, P> {
  Future<R> call(P value);
}

/// Callable class that creates a [Future] from a parameter.
///
/// Type parameter R is the type parameter of the created future.
/// Type parameter P1 is the type of the 1st parameter of `call` method.
/// Type parameter P2 is the type of the 2nd parameter of `call` method.
abstract class FutureCreator2<R, P1, P2> {
  Future<R> call(P1 value1, P2 value2);
}

/// Callable class that creates a [Stream].
///
/// Type parameter R is the type parameter of the created stream.
abstract class StreamCreator<R> {
  Stream<R> call();
}

/// Callable class that creates a [Stream] from a parameter.
///
/// Type parameter R is the type parameter of the created stream.
/// Type parameter P is the type of the parameter of `call` method.
abstract class StreamCreator1<R, P> {
  Stream<R> call(P value);
}

/// Callable class that creates a [Stream] from a parameter.
///
/// Type parameter R is the type parameter of the created stream.
/// Type parameter P is the type of the 1st parameter of `call` method.
/// Type parameter P is the type of the 2nd parameter of `call` method.
abstract class StreamCreator2<R, P1, P2> {
  Stream<R> call(P1 value1, P2 value2);
}
