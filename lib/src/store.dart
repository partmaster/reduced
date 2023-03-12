// store.dart

import 'package:flutter/foundation.dart' show ValueGetter;

import 'event.dart';

/// A function that accepts a parameter of type [Event].
///
/// State management instances can provide this method
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
typedef Dispatcher<S> = void Function(Event<S>);

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
  /// When the method is executed, the passed `event.call` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The `event.call` must be executed synchronously.
  void dispatch(Event<S> event);

  @override
  toString() => '$runtimeType}';
}

/// A ReducedStoreProxy is an implementation of ReducedStore as a proxy.
///
/// The type parameter `S` is the type of the state of the ReducedStore.
class ReducedStoreProxy<S> extends ReducedStore<S> {
  const ReducedStoreProxy(
    ValueGetter<S> state,
    Dispatcher<S> dispatcher,
    this.identity,
  )   : _state = state,
        _dispatcher = dispatcher;

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  final ValueGetter<S> _state;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `event.call` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The `event.call` must be executed synchronously.
  final Dispatcher<S> _dispatcher;

  /// Controls the value semantics of this class.
  ///
  /// This class delegates its [hashCode] and [operator==] methods to the `identity` object.
  final Object identity;

  @override
  get state => _state();

  @override
  dispatch(event) => _dispatcher(event);

  /// This class delegates [hashCode] to the [identity] object.
  @override
  get hashCode => identity.hashCode;

  /// This class delegates [operator==] to the [identity] object.
  @override
  operator ==(other) =>
      other is ReducedStoreProxy<S> && identity == other.identity;

  @override
  toString() => '${identity.runtimeType}';
}
