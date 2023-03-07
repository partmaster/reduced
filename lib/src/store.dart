// store.dart

import 'package:flutter/foundation.dart' show ValueGetter;

import 'reducer.dart';

/// A function that accepts a parameter of type [Reducer].
///
/// State management instances can provide this method
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
typedef Reduce<S> = void Function(Reducer<S>);

/// An ReducedStore is an abstraction for a state management instance.
///
/// The type parameter `S` is the type of the state of the state management instance.
abstract class ReducedStore<S> {
  const ReducedStore();

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  S get state;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `reducer` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The reducer must be executed synchronously.
  void reduce(Reducer<S> reducer);
}

/// A ReducedStoreProxy is an implementation of ReducedStore as a proxy.
///
/// The type parameter `S` is the type of the state of the ReducedStore.
class ReducedStoreProxy<S> extends ReducedStore<S> {
  const ReducedStoreProxy(
    ValueGetter<S> state,
    Reduce<S> reduce,
    this.identity,
  )   : _state = state,
        _reduce = reduce;

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  final ValueGetter<S> _state;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `reducer` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The reducer must be executed synchronously.
  final Reduce<S> _reduce;

  /// Controls the value semantics of this class.
  ///
  /// This class delegates its [hashCode] and [operator==] methods to the `identity` object.
  final Object identity;

  @override
  get state => _state();

  @override
  reduce(reducer) => _reduce(reducer);

  /// This class delegates [hashCode] to the [identity] object.
  @override
  get hashCode => identity.hashCode;

  /// This class delegates [operator==] to the [identity] object.
  @override
  operator ==(other) =>
      other is ReducedStoreProxy<S> && identity == other.identity;
}
