// internal.dart

import 'package:flutter/foundation.dart' show UniqueKey, ValueGetter;

import 'event.dart';
import 'functions.dart';
import 'store.dart';

/// A StoreProxy is an implementation of interface Store as a proxy.
///
/// The type parameter `S` is the type of the state of the Store.
class StoreProxy<S> extends Store<S> {
  const StoreProxy(
    ValueGetter<S> state,
    this.processor,
    this.identity, [
    this.listener,
  ]) : _state = state;

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  final ValueGetter<S> _state;

  /// Updates the state of the state management instance.
  ///
  /// When the processor is executed, the passed `event.call` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The `event.call` must be executed synchronously.
  final EventAcceptor<S> processor;

  /// Controls the value semantics of this class.
  ///
  /// This class delegates its [hashCode] and [operator==] methods to the `identity` object.
  final Object identity;

  /// Is called each time after an event is processed and the new state is stored.
  final EventListener<S>? listener;

  @override
  get state => _state();

  @override
  process(event) {
    processor(event);
    listener?.call(this, event, UniqueKey());
  }

  /// This class delegates [hashCode] to the [identity] object.
  @override
  get hashCode => identity.hashCode;

  /// This class delegates [operator==] to the [identity] object.
  @override
  operator ==(other) => other is StoreProxy<S> && identity == other.identity;

  @override
  toString() => '${identity.runtimeType}';
}

/// A decorator for an [EventListener] that skips events if they are equal to the previous event.
///
/// The type parameter `S` is the type of the decorated [EventListener].
class DistinctEventListener<S> {
  final EventListener<S> decorated;
  UniqueKey? _key;

  DistinctEventListener(this.decorated);

  void call(Store<S> store, Event<S> event, UniqueKey key) {
    if (key != _key) {
      _key = key;
      decorated(store, event, key);
    }
  }

  static EventListener<S>? decorate<S>(
    EventListener<S>? decorated,
  ) =>
      decorated == null ? null : DistinctEventListener<S>(decorated).call;
}
