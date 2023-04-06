// parametrized.dart

import 'event.dart';

/// Parametrizes an Event with 1 fixed value.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V` is the type of the value.
class Parametrized1Event<S, V> extends Event<S> {
  const Parametrized1Event(this.adapted, this.value);

  final Event1<S, V> adapted;

  /// The value used as parameter in adapted.call.
  final V value;

  @override
  call(state) => adapted.call(state, value);

  @override
  get hashCode => Object.hash(adapted, value);

  @override
  operator ==(other) =>
      other is Parametrized1Event &&
      adapted == other.adapted &&
      value == other.value;

  @override
  toString() => '$adapted($value)';
}

/// Parametrizes an Event with 2 fixed values.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
class Parametrized2Event<S, V1, V2> extends Event<S> {
  const Parametrized2Event(this.adapted, this.value1, this.value2);

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
      other is Parametrized2Event &&
      adapted == other.adapted &&
      value1 == other.value1 &&
      value2 == other.value2;

  @override
  toString() => '$adapted($value1, $value2)';
}

/// Parametrizes an Event with 3 fixed values.
///
/// The type parameter `S` is the type of the state.
/// The type parameter `V1` is the type of the 1st value.
/// The type parameter `V2` is the type of the 2nd value.
/// The type parameter `V3` is the type of the 3rd value.
class Parametrized3Event<S, V1, V2, V3> extends Event<S> {
  Parametrized3Event(this.adapted, this.value1, this.value2, this.value3);

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
      other is Parametrized3Event &&
      adapted == other.adapted &&
      value1 == other.value1 &&
      value2 == other.value2 &&
      value3 == other.value3;

  @override
  toString() => '$adapted($value1, $value2, $value3)';
}
