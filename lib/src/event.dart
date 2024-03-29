// event.dart

import 'callable.dart';

/// A Event creates from a given state a new state of the same type.
///
/// Because the Event is used as a property in [Callable] implementations for callbacks,
/// and therefore requires value semantics, Events are modeled as a class rather than a function.
abstract class Event<S> {
  const Event();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state);

  @override
  toString() => '$runtimeType';
}

/// A Event creates from a given state and a value a new state of the same type.
///
/// Because the Event1 is used as a property in [Callable1] implementations for callbacks,
/// and therefore requires value semantics, Events are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V defines the type of the 2nd parameter of the call method.
abstract class Event1<S, V> {
  const Event1();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V value);

  @override
  toString() => '$runtimeType';
}

/// A Event creates from a given state and two values a new state of the same type.
///
/// Because the Event2 is used as a property in [Callable2] implementations for callbacks,
/// and therefore requires value semantics, Events are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V1 defines the type of the 2nd parameter of the call method.
/// The type parameter V2 defines the type of the 3rd parameter of the call method.
abstract class Event2<S, V1, V2> {
  const Event2();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V1 value1, V2 value2);

  @override
  toString() => '$runtimeType';
}

/// A Event creates from a given state and three values a new state of the same type.
///
/// Because the Event3 is used as a property in [Callable3] implementations for callbacks,
/// and therefore requires value semantics, Events are modeled as a class rather than a function.
///
/// The type parameter S defines the return type and the 1st parameter type of the call method.
/// The type parameter V1 defines the type of the 2nd parameter of the call method.
/// The type parameter V2 defines the type of the 3rd parameter of the call method.
/// The type parameter V3 defines the type of the 4th parameter of the call method.
abstract class Event3<S, V1, V2, V3> {
  const Event3();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state, V1 value1, V2 value2, V3 value3);

  @override
  toString() => '$runtimeType';
}

/// Event class for [Future.then] and [Stream.listen] `onError` callback parameter.
typedef ErrorEvent<S> = Event2<S, Object, StackTrace>;

/// A decorator that adds an callback to an [Event], that is called after the event.
///
/// The type parameter S is the type parameter of the decorated event.
class AfterEventDecorator<S> extends Event<S> {
  final Event<S> event;
  final Callable<void> after;

  AfterEventDecorator(this.event, this.after);

  @override
  S call(S state) {
    final result = event(state);
    after();
    return result;
  }

  @override
  get hashCode => Object.hash(event, after);

  @override
  operator ==(other) =>
      other is AfterEventDecorator<S> &&
      event == other.event &&
      after == other.after;

  @override
  String toString() => '$event';
}

/// A decorator that adds an callback to an [Event1], that is called after the event.
///
/// The type parameter S is the 1st type parameter of the decorated event.
/// The type parameter P is the 2nd type parameter of the decorated event.
class AfterEvent1Decorator<S, P> extends Event1<S, P> {
  final Event1<S, P> event;
  final Callable<void> after;

  AfterEvent1Decorator(this.event, this.after);

  @override
  S call(S state, P value) {
    final result = event(state, value);
    after();
    return result;
  }

  @override
  get hashCode => Object.hash(event, after);

  @override
  operator ==(other) =>
      other is AfterEvent1Decorator<S, P> &&
      event == other.event &&
      after == other.after;

  @override
  String toString() => '$event';
}
