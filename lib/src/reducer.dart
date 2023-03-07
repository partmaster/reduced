// reducer.dart

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

/// Adapts a Reducer1 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V` is the type of the value.
class Reducer1Adapter<S, V> extends Reducer<S> {
  const Reducer1Adapter(this.adaptee, this.value);

  final Reducer1<S, V> adaptee;

  /// The value used as parameter in adaptee.call.
  final V value;

  @override
  call(state) => adaptee.call(state, value);

  @override
  get hashCode => Object.hash(adaptee, value);

  @override
  operator ==(other) =>
      other is Reducer1Adapter &&
      adaptee == other.adaptee &&
      value == other.value;
}

/// Adapts a Reducer2 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
class Reducer2Adapter<S, V1, V2> extends Reducer<S> {
  const Reducer2Adapter(this.adaptee, this.value1, this.value2);

  final Reducer2<S, V1, V2> adaptee;

  /// The value used as parameter in adaptee.call.
  final V1 value1;

  /// The value used as parameter in adaptee.call.
  final V2 value2;

  @override
  call(state) => adaptee.call(state, value1, value2);

  @override
  get hashCode => Object.hash(adaptee, value1, value2);

  @override
  operator ==(other) =>
      other is Reducer2Adapter &&
      adaptee == other.adaptee &&
      value1 == other.value1 &&
      value2 == other.value2;
}

/// Adapts a Reducer3 as Reducer.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
/// The type parameter `V3` is the type of the 3rd value.
class Reducer3Adapter<S, V1, V2, V3> extends Reducer<S> {
  Reducer3Adapter(
      this.adaptee, this.value1, this.value2, this.value3);

  final Reducer3<S, V1, V2, V3> adaptee;

  /// The value used as parameter in adaptee.call.
  final V1 value1;

  /// The value used as parameter in adaptee.call.
  final V2 value2;

  /// The value used as parameter in adaptee.call.
  final V3 value3;

  @override
  call(state) => adaptee.call(state, value1, value2, value3);

  @override
  get hashCode => Object.hash(adaptee, value1, value2, value3);

  @override
  operator ==(other) =>
      other is Reducer3Adapter &&
      adaptee == other.adaptee &&
      value1 == other.value1 &&
      value2 == other.value2 &&
      value3 == other.value3;
}
