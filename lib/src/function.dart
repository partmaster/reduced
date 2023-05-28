// function.dart

import 'package:flutter/foundation.dart' show Key, UniqueKey;
import 'package:flutter/widgets.dart' show Widget;
import 'package:reduced/src/routing.dart';

import 'event.dart';
import 'store.dart';

/// A function that maps store date to props.
///
/// The type parameter `S` is the type of the [StoreSnapshot].
/// The type parameter `P` is the return type of the function.
typedef SnapshotToPropsMapper<S, P> = P Function(
  StoreSnapshot<S> snapshot,
  RoutingContext routingContext,
);

/// A function that maps double store data to props.
///
/// The type parameter `S1` is the type of the 1st [StoreSnapshot].
/// The type parameter `S2` is the type of the 2nd [StoreSnapshot].
/// The type parameter `P` is the return type of the function.
typedef SnapshotsToPropsMapper<S1, S2, P> = P Function(
  StoreSnapshot<S1> snapshot1,
  StoreSnapshot<S2> snapshot2,
  RoutingContext routingContext,
);

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
/// The type parameter `S` is the type of the Event.
typedef EventListener<S> = void Function(
  StoreSnapshot<S> snapshot,
  Event<S> event,
  UniqueKey key,
);

/// A function that accepts an Event as parameter.
///
/// The type parameter `S` is the type of the Event.
typedef EventAcceptor<S> = void Function(Event<S> event);
