// callable.dart

import 'event.dart';
import 'store.dart';

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

/// An implementation of a callback as a [ReducedStore.dispatch](ReducedStore.dispatch) call with a [Event].
///
/// Or in other words, a [Event] bonded to a [ReducedStore] useable as callback.
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [ReducedStore].
class CallableAdapter<S> extends Callable<void> {
  const CallableAdapter(this.store, this.event);

  /// The store to whose method [dispatch](ReducedStore.dispatch)
  /// the [event] is passed when the method [call] is called.
  final ReducedStore<S> store;

  /// The reducer that is passed as a parameter to the [dispatch](ReducedStore.dispatch) method
  /// of the [store] when the [call] method is called.
  final Event<S> event;

  /// Executes the [dispatch](ReducedStore.dispatch) method of the [store]
  /// with the [event] as parameter.
  @override
  call() => store.dispatch(event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(store, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is CallableAdapter && event == other.event && store == other.store;

  @override
  toString() => '$event@$store}';
}

/// An implementation of a callback as a [ReducedStore.dispatch](ReducedStore.dispatch) call with a [Event1].
///
/// Or in other words, a [Event] bonded to a [ReducedStore] useable as callback.
///
/// The type parameter `S` is the type of the state of the [ReducedStore].
/// The type parameter `V` is the type of the value of the [Event1].
class Callable1Adapter<S, V> extends Callable1<void, V> {
  const Callable1Adapter(this.store, this.event);

  /// The store to whose method [dispatch](ReducedStore.dispatch)
  /// the [event] is passed when the method [call] is called.
  final ReducedStore<S> store;

  /// The reducer that is passed as a parameter to the [dispatch](ReducedStore.dispatch) method
  /// of the [store] when the [call] method is called.
  final Event1<S, V> event;

  /// Executes the [dispatch](ReducedStore.dispatch) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value) => store.dispatch(Event1Adapter(event, value));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(store, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable1Adapter && event == other.event && store == other.store;

  @override
  toString() => '$event@$store}';
}

/// An implementation of a callback as a [ReducedStore.dispatch](ReducedStore.dispatch) call with a [Event2].
///
/// Or in other words, a [Event2] bonded to a [ReducedStore] useable as callback.
///
/// The type parameter `S` is the type of the state of the [ReducedStore].
/// The type parameter `V1` is the type of the 1st value of the [Event2].
/// The type parameter `V2` is the type of the 2nd value of the [Event2].
class Callable2Adapter<S, V1, V2> extends Callable2<void, V1, V2> {
  const Callable2Adapter(this.store, this.event);

  /// The store to whose method [dispatch](ReducedStore.dispatch)
  /// the [event] is passed when the method [call] is called.
  final ReducedStore<S> store;

  /// The reducer that is passed as a parameter to the [dispatch](ReducedStore.dispatch) method
  /// of the [store] when the [call] method is called.
  final Event2<S, V1, V2> event;

  /// Executes the [dispatch](ReducedStore.dispatch) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value1, value2) => store.dispatch(Event2Adapter(event, value1, value2));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(store, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable2Adapter && event == other.event && store == other.store;

  @override
  toString() => '$event@$store}';
}

/// An implementation of a callback as a [ReducedStore.dispatch](ReducedStore.dispatch) call with a [Event3].
///
/// Or in other words, a [Event3] bonded to a [ReducedStore] useable as callback.
///
/// The type parameter `S` is the type of the state of the [ReducedStore].
/// The type parameter `V1` is the type of the 1st value of the [Event3].
/// The type parameter `V2` is the type of the 2nd value of the [Event3].
/// The type parameter `V3` is the type of the 3rd value of the [Event3].
class Callable3Adapter<S, V1, V2, V3> extends Callable3<void, V1, V2, V3> {
  const Callable3Adapter(this.store, this.event);

  /// The store to whose method [dispatch](ReducedStore.dispatch)
  /// the [event] is passed when the method [call] is called.
  final ReducedStore<S> store;

  /// The reducer that is passed as a parameter to the [dispatch](ReducedStore.dispatch) method
  /// of the [store] when the [call] method is called.
  final Event3<S, V1, V2, V3> event;

  /// Executes the [dispatch](ReducedStore.dispatch) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value1, value2, value3) =>
      store.dispatch(Event3Adapter(event, value1, value2, value3));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(store, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Callable3Adapter && event == other.event && store == other.store;

  @override
  toString() => '$event@$store}';
}
