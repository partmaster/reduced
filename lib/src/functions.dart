// functions.dart

import 'package:flutter/foundation.dart' show Key, UniqueKey;
import 'package:flutter/widgets.dart' show Widget;

import 'event.dart';
import 'store.dart';

/// A function that maps the current state of a store to props.
///
/// The type parameter `S` is the type of the state of the [Store].
/// The type parameter `P` is the return type of the function.
typedef StateToPropsMapper<S, P> = P Function(Store<S>);

// A function that builds a Widget from a props parameter.
///
/// The type parameter `P` is the type of the parameter.
typedef WidgetFromPropsBuilder<P> = Widget Function({
  Key? key,
  required P props,
});

/// A function that can be registered as an event listener at a Store.
///
/// A registered listener is called by the Store at the end of each dispatch method execution.
typedef EventListener<S> = void Function(
  Store<S> store,
  Event<S> event,
  UniqueKey key,
);

/// A function that processes a parameter of type [Event].
///
/// State management instances can provide this method
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
typedef EventProcessor<S> = void Function(Event<S>);
