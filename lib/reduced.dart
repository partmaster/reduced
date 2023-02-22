// reducible.dart

/// Abstractions for a state management instance.
/// Enables decoupling of UI and logic from the state management framework used.
library reduced;

import 'package:flutter/foundation.dart' show ValueGetter;

/// An abstraction for callbacks without parameters in the form of a class to easily implement value semantics.
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

/// A Reducer creates from a given state a new state of the same type.
///
/// Because the Reducer is used as a property in [Callable] implementations for callbacks,
/// and therefore requires value semantics, Reducers are modeled as a class rather than a function.
abstract class Reducer<S> {
  const Reducer();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state);
}

/// A Reducer creates from a given state and a value a new state of the same type.
///
/// Because the Reducer1 is used as a property in [Callable1] implementations for callbacks,
/// and therefore requires value semantics, Reducers are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V defines the type of the 2nd parameter of the call method.
abstract class Reducer1<S, V> {
  const Reducer1();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V value);
}

/// A Reducer creates from a given state and two values a new state of the same type.
///
/// Because the Reducer2 is used as a property in [Callable2] implementations for callbacks,
/// and therefore requires value semantics, Reducers are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V1 defines the type of the 2nd parameter of the call method.
/// The type parameter V2 defines the type of the 3rd parameter of the call method.
abstract class Reducer2<S, V1, V2> {
  const Reducer2();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V1 value1, V2 value2);
}

/// A Reducer creates from a given state and three values a new state of the same type.
///
/// Because the Reducer3 is used as a property in [Callable3] implementations for callbacks,
/// and therefore requires value semantics, Reducers are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V1 defines the type of the 2nd parameter of the call method.
/// The type parameter V2 defines the type of the 3rd parameter of the call method.
/// The type parameter V3 defines the type of the 4th parameter of the call method.
abstract class Reducer3<S, V1, V2, V3> {
  const Reducer3();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V1 value1, V2 value2, V3 value3);
}

/// A function that accepts a parameter of type [Reducer].
///
/// State management instances can provide this method
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
typedef Reduce<S> = void Function(Reducer<S>);

/// An Reducible is an abstraction for a state management instance.
///
/// The type parameter `S` is the type of the state of the state management instance.
abstract class Reducible<S> {
  const Reducible();

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  ValueGetter<S> get getState;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `reducer` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The reducer must be executed synchronously.
  Reduce<S> get reduce;
}

/// A ReducibleProxy is an implementation of Reducible as a proxy.
///
/// The type parameter `S` is the type of the state of the Reducible.
class ReducibleProxy<S> extends Reducible<S>{
  const ReducibleProxy(this.getState, this.reduce, this.identity);

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  @override
  final ValueGetter<S> getState;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `reducer` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The reducer must be executed synchronously.
  @override
  final Reduce<S> reduce;

  /// Controls the value semantics of this class.
  ///
  /// This class delegates its [hashCode] and [operator==] methods to the `identity` object.
  final Object identity;

  /// This class delegates the [hashCode] method to the [identity] object.
  @override
  int get hashCode => identity.hashCode;

  /// This class delegates the [operator==] method to the [identity] object.
  @override
  bool operator ==(Object other) =>
      other is ReducibleProxy<S> && identity == other.identity;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Reducible].
class ReducerOnReducible<S> extends Callable<void> {
  const ReducerOnReducible(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer<S> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  void call() => reducible.reduce(reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is ReducerOnReducible &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Reducible].
class Reducer1OnReducible<S, P> extends Callable1<void, P> {
  const Reducer1OnReducible(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer1<S, P> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  void call(P p) => reducible.reduce(Reducer1Adapter(reducer, p));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is Reducer1OnReducible &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Reducible].
class Reducer2OnReducible<S, V1, V2> extends Callable2<void, V1, V2> {
  const Reducer2OnReducible(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer2<S, V1, V2> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  void call(V1 value1, V2 value2) =>
      reducible.reduce(Reducer2Adapter(reducer, value1, value2));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is Reducer2OnReducible &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// An implementation of a callback as a [Reducible.reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Reducible].
class Reducer3OnReducible<S, V1, V2, V3> extends Callable3<void, V1, V2, V3> {
  const Reducer3OnReducible(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce)
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method
  /// of the [reducible] when the [call] method is called.
  final Reducer3<S, V1, V2, V3> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  void call(V1 value1, V2 value2, V3 value3) =>
      reducible.reduce(Reducer3Adapter(reducer, value1, value2, value3));

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters
  /// [reducible] and [reducer] should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is Reducer3OnReducible &&
      reducer == other.reducer &&
      reducible == other.reducible;
}

/// Adapts a Reducer1 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V` is the type of the value.
class Reducer1Adapter<S, V> extends Reducer<S> {
  final Reducer1<S, V> adaptee;
  final V value;

  Reducer1Adapter(this.adaptee, this.value);

  @override
  call(state) => adaptee.call(state, value);
}

/// Adapts a Reducer2 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
class Reducer2Adapter<S, V1, V2> extends Reducer<S> {
  final Reducer2<S, V1, V2> adaptee;
  final V1 value1;
  final V2 value2;

  Reducer2Adapter(this.adaptee, this.value1, this.value2);

  @override
  call(state) => adaptee.call(state, value1, value2);
}

/// Adapts a Reducer3 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
/// The type parameter `V3` is the type of the 3rd value.
class Reducer3Adapter<S, V1, V2, V3> extends Reducer<S> {
  final Reducer3<S, V1, V2, V3> adaptee;
  final V1 value1;
  final V2 value2;
  final V3 value3;

  Reducer3Adapter(this.adaptee, this.value1, this.value2, this.value3);

  @override
  call(state) => adaptee.call(state, value1, value2, value3);
}
