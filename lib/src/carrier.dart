// carrier.dart

import 'callable.dart';
import 'creator.dart';
import 'event.dart';
import 'parametrized.dart';
import 'store.dart';

/// An implementation of a callback as a [Store.process](Store.process) call with a [Event].
///
/// Or in other words, the callback carries the [Event] to the [Store].
/// Can be assigned to Widget properties of type [VoidCallback].
/// The type parameter `S` is the type of the state of the [Store].
class EventCarrier<S> extends Callable<void> {
  const EventCarrier(this.processor, this.event);

  /// The store to whose method [process](Store.process)
  /// the [event] is passed when the method [call] is called.
  final EventProcessor<S> processor;

  /// The reducer that is passed as a parameter to the [process](Store.process) method
  /// of the [store] when the [call] method is called.
  final Event<S> event;

  /// Executes the [process](Store.process) method of the [store]
  /// with the [event] as parameter.
  @override
  call() => processor.process(event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(processor, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is EventCarrier &&
      event == other.event &&
      processor == other.processor;

  @override
  toString() => '$event@$processor}';
}

/// An implementation of a callback as a [Store.process](Store.process) call with a [Event1].
///
/// Or in other words, the callback carries the [Event1] to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `V` is the type of the value of the [Event1].
class Event1Carrier<S, V> extends Callable1<void, V> {
  const Event1Carrier(this.processor, this.event);

  /// The store to whose method [process](Store.process)
  /// the [event] is passed when the method [call] is called.
  final EventProcessor<S> processor;

  /// The reducer that is passed as a parameter to the [process](Store.process) method
  /// of the [store] when the [call] method is called.
  final Event1<S, V> event;

  /// Executes the [process](Store.process) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value) => processor.process(Parametrized1Event(event, value));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(processor, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Event1Carrier &&
      event == other.event &&
      processor == other.processor;

  @override
  toString() => '$event@$processor}';
}

/// An implementation of a callback as a [Store.process](Store.process) call with a [Event2].
///
/// Or in other words, the callback carries the [Event2] to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `V1` is the type of the 1st value of the [Event2].
/// The type parameter `V2` is the type of the 2nd value of the [Event2].
class Event2Carrier<S, V1, V2> extends Callable2<void, V1, V2> {
  const Event2Carrier(this.processor, this.event);

  /// The store to whose method [process](Store.process)
  /// the [event] is passed when the method [call] is called.
  final EventProcessor<S> processor;

  /// The reducer that is passed as a parameter to the [process](Store.process) method
  /// of the [store] when the [call] method is called.
  final Event2<S, V1, V2> event;

  /// Executes the [process](Store.process) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value1, value2) =>
      processor.process(Parametrized2Event(event, value1, value2));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(processor, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Event2Carrier &&
      event == other.event &&
      processor == other.processor;

  @override
  toString() => '$event@$processor}';
}

/// An implementation of a callback as a [Store.process](Store.process) call with a [Event3].
///
/// Or in other words, the callback carries the [Event3] to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `V1` is the type of the 1st value of the [Event3].
/// The type parameter `V2` is the type of the 2nd value of the [Event3].
/// The type parameter `V3` is the type of the 3rd value of the [Event3].
class Event3Carrier<S, V1, V2, V3> extends Callable3<void, V1, V2, V3> {
  const Event3Carrier(this.processor, this.event);

  /// The store to whose method [process](Store.process)
  /// the [event] is passed when the method [call] is called.
  final EventProcessor<S> processor;

  /// The reducer that is passed as a parameter to the [process](Store.process) method
  /// of the [store] when the [call] method is called.
  final Event3<S, V1, V2, V3> event;

  /// Executes the [process](Store.process) method of the [store]
  ///  with the [event] as parameter.
  @override
  call(value1, value2, value3) =>
      processor.process(Parametrized3Event(event, value1, value2, value3));

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  get hashCode => Object.hash(processor, event);

  /// For this class to have value semantics, both constructor parameters
  /// [store] and [event] should have value semantics.
  @override
  operator ==(other) =>
      other is Event3Carrier &&
      event == other.event &&
      processor == other.processor;

  @override
  toString() => '$event@$processor}';
}

/// An implementation of a callback as a [Store.process](Store.process) call of an event when a future completes.
///
/// Or in other words, the callback carries the event with the result of the future to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `R` is the type of the future.
class FutureCreatorEventCarrier<S, R> extends Callable<void> {
  final EventProcessor<S> processor;
  final Event<S>? onStarted;
  final FutureCreator<R> creator;
  final Event1<S, R> onValue;
  final ErrorEvent<S>? onError;

  FutureCreatorEventCarrier({
    required this.processor,
    required this.creator,
    this.onStarted,
    required this.onValue,
    this.onError,
  });

  @override
  call() {
    if (onStarted != null) {
      processor.process(onStarted!);
    }
    creator().then(
      (completedValue) => processor.process(
        Parametrized1Event(
          onValue,
          completedValue,
        ),
      ),
      onError: onError == null
          ? null
          : (error, stacktrace) => processor.process(
                Parametrized2Event(onError!, error, stacktrace),
              ),
    );
  }
}

/// An implementation of a callback as a [Store.process](Store.process) call of an event when a future completes.
///
/// Or in other words, the callback carries the event with the result of the future to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `R` is the type of the future.
/// The type parameter `P` is the type of the parameter that is transfered form the callable to the  future creator.
class FutureCreator1EventCarrier<S, R, P> extends Callable1<void, P> {
  final EventProcessor<S> processor;
  final FutureCreator1<R, P> creator;
  final Event<S>? onStarted;
  final Event1<S, R> onValue;
  final ErrorEvent<S>? onError;

  FutureCreator1EventCarrier({
    required this.processor,
    this.onStarted,
    required this.creator,
    required this.onValue,
    this.onError,
  });

  @override
  call(value) {
    if (onStarted != null) {
      processor.process(onStarted!);
    }
    creator(value).then(
      (futureValue) => processor.process(
        Parametrized1Event(onValue, futureValue),
      ),
      onError: onError == null
          ? null
          : (error, stacktrace) => processor.process(
                Parametrized2Event(onError!, error, stacktrace),
              ),
    );
  }
}

/// An implementation of a callback as multiple [Store.process](Store.process) calls of events when a stream emits.
///
/// Or in other words, the callback carries the events with the emitted data of the stream to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `R` is the type of the stream.
class StreamCreatorEventCarrier<S, R> extends Callable<void> {
  final EventProcessor<S> processor;
  final StreamCreator<R> creator;
  final Event<S>? onStarted;
  final Event1<S, R> onData;
  final Event<S>? onDone;
  final ErrorEvent<S>? onError;

  StreamCreatorEventCarrier({
    required this.processor,
    this.onStarted,
    required this.creator,
    required this.onData,
    this.onDone,
    this.onError,
  });

  @override
  call() {
    if (onStarted != null) {
      processor.process(onStarted!);
    }
    creator().listen(
      (data) => processor.process(Parametrized1Event(onData, data)),
      onDone: onDone == null ? null : () => processor.process(onDone!),
      onError: onError == null
          ? null
          : (error, stacktrace) => processor.process(
                Parametrized2Event(onError!, error, stacktrace),
              ),
    );
  }
}

/// An implementation of a callback as multiple [Store.process](Store.process) calls of events when a stream emits.
///
/// Or in other words, the callback carries the events with the emitted data of the stream to the [Store].
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `R` is the type of the future.
/// The type parameter `P` is the type of the parameter that is transfered form the callable to the stream creator.
class StreamCreator1EventCarrier<S, R, P> extends Callable1<void, P> {
  final EventProcessor<S> processor;
  final StreamCreator1<R, P> creator;
  final Event<S>? onStarted;
  final Event1<S, R> onData;
  final Event<S>? onDone;
  final ErrorEvent<S>? onError;

  StreamCreator1EventCarrier({
    required this.processor,
    this.onStarted,
    required this.creator,
    required this.onData,
    this.onDone,
    this.onError,
  });

  @override
  call(P value) {
    if (onStarted != null) {
      processor.process(onStarted!);
    }
    creator(value).listen(
      (data) => processor.process(Parametrized1Event(onData, data)),
      onDone: onDone == null ? null : () => processor.process(onDone!),
      onError: onError == null
          ? null
          : (error, stacktrace) => processor.process(
                Parametrized2Event(onError!, error, stacktrace),
              ),
    );
  }
}
