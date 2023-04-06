// store.dart

import 'event.dart';

/// An interface to process an event [Event].
///
/// State management instances can provide this interface
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
abstract class EventProcessor<S> {
  const EventProcessor();

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `event.call` is called
  /// with the current state of the state management instance
  /// and the return value is taken as the new state of the state management instance.
  /// The `event.call` must be executed synchronously.
  void process(Event<S> event);
}

/// A Store is an abstraction for a state management instance.
///
/// The type parameter `S` is the type of the state of the state management instance.
abstract class Store<S> extends EventProcessor<S> {
  const Store();

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  S get state;

  @override
  toString() => '$runtimeType';
}
