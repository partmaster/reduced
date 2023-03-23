// creator.dart

/// Callable class that creates a [Future] from a parameter.
///
/// Type parameter R is the type parameter of the created future.
/// Type parameter P is the type of the parameter of `call` method.
abstract class FutureCreator<R, P> {
  Future<R> call(P value);
}

/// Callable class that creates a [Stream] from a parameter.
///
/// Type parameter R is the type parameter of the created stream.
/// Type parameter P is the type of the parameter of `call` method.
abstract class StreamCreator<R, P> {
  Stream<R> call(P value);
}
