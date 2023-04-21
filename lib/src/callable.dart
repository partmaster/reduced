// callable.dart

import 'package:collection/collection.dart';

/// An abstraction for callbacks without parameters in the form of a class to easily implement value semantics.
///
/// Can be assigned to Widget callback properties without parameters, e.g. [VoidCallback]
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change,
/// the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods,
/// often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
///
/// The type parameter R defines the return type of the call method.
abstract class Callable<R> {
  const Callable();

  /// Allows to use this class like a method.
  R call();

  @override
  toString() => '$runtimeType';
}

/// An abstraction for callbacks with one parameter in the form of a class to easily implement value semantics.
///
/// Can be assigned to Widget callback properties with one parameter, e.g. [ValueChanged].
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change,
/// the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods,
/// often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
///
/// The type parameter R defines the return type of the call method.
/// The type parameter V defines the type of the parameter of the call method.
abstract class Callable1<R, V> {
  const Callable1();

  /// Allows to use this class like a method.
  R call(V value);

  @override
  toString() => '$runtimeType';
}

/// An abstraction for callbacks with two parameters in the form of a class to easily implement value semantics.
///
/// Can be assigned to Widget callback properties with two parameters, e.g. [LocaleResolutionCallback].
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change,
/// the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods,
/// often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
///
/// The type parameter R defines the return type of the call method.
/// The type parameter V1 defines the type of the 1st parameter of the call method.
/// The type parameter V2 defines the type of the 2nd parameter of the call method.
abstract class Callable2<R, V1, V2> {
  const Callable2();

  /// Allows to use this class like a method.
  R call(V1 value1, V2 value2);

  @override
  toString() => '$runtimeType';
}

/// An abstraction for callbacks with three parameters in the form of a class to easily implement value semantics.
///
/// Can be assigned to Widget callback properties with three parameters, e.g. [TweenVisitor].
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change,
/// the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods,
/// often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
///
/// The type parameter R defines the return type of the call method.
/// The type parameter V1 defines the type of the 1st parameter of the call method.
/// The type parameter V2 defines the type of the 2nd parameter of the call method.
/// The type parameter V3 defines the type of the 3rd parameter of the call method.
abstract class Callable3<R, V1, V2, V3> {
  const Callable3();

  /// Allows to use this class like a method.
  R call(V1 value1, V2 value2, V3 value3);

  @override
  toString() => '$runtimeType';
}

/// A list of callables that can be used as single callable.
class CompositeCallable extends Callable<void> {
  const CompositeCallable(this.callables);

  final List<Callable<void>> callables;

  @override
  call() {
    for (final callable in callables) {
      callable();
    }
  }

  @override
  get hashCode => Object.hashAll(callables);

  @override
  operator ==(other) =>
      other is CompositeCallable &&
      const ListEquality().equals(callables, other.callables);
}
