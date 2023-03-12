// event.dart

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

/// Adapts a Event1 as Event.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V` is the type of the value.
class Event1Adapter<S, V> extends Event<S> {
  const Event1Adapter(this.adapted, this.value);

  final Event1<S, V> adapted;

  /// The value used as parameter in adapted.call.
  final V value;

  @override
  call(state) => adapted.call(state, value);

  @override
  get hashCode => Object.hash(adapted, value);

  @override
  operator ==(other) =>
      other is Event1Adapter &&
      adapted == other.adapted &&
      value == other.value;

  @override
  toString() => '${adapted.runtimeType}($value)';
}

/// Adapts a Event2 as Event.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
class Event2Adapter<S, V1, V2> extends Event<S> {
  const Event2Adapter(this.adapted, this.value1, this.value2);

  final Event2<S, V1, V2> adapted;

  /// The value used as parameter in adapted.call.
  final V1 value1;

  /// The value used as parameter in adapted.call.
  final V2 value2;

  @override
  call(state) => adapted.call(state, value1, value2);

  @override
  get hashCode => Object.hash(adapted, value1, value2);

  @override
  operator ==(other) =>
      other is Event2Adapter &&
      adapted == other.adapted &&
      value1 == other.value1 &&
      value2 == other.value2;

  @override
  toString() => '${adapted.runtimeType}($value1, $value2)';
}

/// Adapts a Event3 as Event.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
/// The type parameter `V3` is the type of the 3rd value.
class Event3Adapter<S, V1, V2, V3> extends Event<S> {
  Event3Adapter(this.adapted, this.value1, this.value2, this.value3);

  final Event3<S, V1, V2, V3> adapted;

  /// The value used as parameter in adapted.call.
  final V1 value1;

  /// The value used as parameter in adapted.call.
  final V2 value2;

  /// The value used as parameter in adapted.call.
  final V3 value3;

  @override
  call(state) => adapted.call(state, value1, value2, value3);

  @override
  get hashCode => Object.hash(adapted, value1, value2, value3);

  @override
  operator ==(other) =>
      other is Event3Adapter &&
      adapted == other.adapted &&
      value1 == other.value1 &&
      value2 == other.value2 &&
      value3 == other.value3;

  @override
  toString() => '${adapted.runtimeType}($value1, $value2, $value3)';
}
