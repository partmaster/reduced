// callable.dart

import 'reducible.dart';

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
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Reducible].
class CallableAdapter<S> extends Callable<void> {
  const CallableAdapter(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer<S> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  call() => reducible.reduce(reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  operator ==(other) =>
      other is CallableAdapter &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer1].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
///
/// The type parameter `S` is the type of the state of the [Reducible].
/// The type parameter `V` is the type of the value of the [Reducer1].
class Callable1Adapter<S, V> extends Callable1<void, V> {
  const Callable1Adapter(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer1<S, V> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  call(value) => reducible.reduce(Reducer1Adapter(reducer, value));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable1Adapter &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer2].
///
/// Or in other words, a [Reducer2] bonded to a [Reducible] useable as callback.
///
/// The type parameter `S` is the type of the state of the [Reducible].
/// The type parameter `V1` is the type of the 1st value of the [Reducer2].
/// The type parameter `V2` is the type of the 2nd value of the [Reducer2].
class Callable2Adapter<S, V1, V2> extends Callable2<void, V1, V2> {
  const Callable2Adapter(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer2<S, V1, V2> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  call(value1, value2) =>
      reducible.reduce(Reducer2Adapter(reducer, value1, value2));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable2Adapter &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer3].
///
/// Or in other words, a [Reducer3] bonded to a [Reducible] useable as callback.
///
/// The type parameter `S` is the type of the state of the [Reducible].
/// The type parameter `V1` is the type of the 1st value of the [Reducer3].
/// The type parameter `V2` is the type of the 2nd value of the [Reducer3].
/// The type parameter `V3` is the type of the 3rd value of the [Reducer3].
class Callable3Adapter<S, V1, V2, V3>
    extends Callable3<void, V1, V2, V3> {
  const Callable3Adapter(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer3<S, V1, V2, V3> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  call(value1, value2, value3) => reducible
      .reduce(Reducer3Adapter(reducer, value1, value2, value3));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable3Adapter &&
      reducer == other.reducer &&
      reducible == other.reducible;
}
