// function.dart

import 'package:flutter/foundation.dart' show Key, UniqueKey;
import 'package:flutter/widgets.dart' show Widget;

import 'event.dart';
import 'store.dart';

/// A function that maps store date to props.
///
/// The type parameter `S` is the type of the [StoreData].
/// The type parameter `P` is the return type of the function.
typedef StoreDataToPropsMapper<S, P> = P Function(StoreData<S> storeData,
    [String? routeName]);

/// A function that maps double store data to props.
///
/// The type parameter `S1` is the type of the 1st [StoreData].
/// The type parameter `S2` is the type of the 2nd [StoreData].
/// The type parameter `P` is the return type of the function.
typedef DoubleStoreDataToPropsMapper<S1, S2, P> = P Function(
  StoreData<S1> appStoreData,
  StoreData<S2> pageStoreData, [
  String? routeName,
]);

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
  StoreData<S> processor,
  Event<S> event,
  UniqueKey key,
);

/// A function that accepts an Event as parameter.
///
/// The type parameter `P` is the type of the Event.
typedef EventAcceptor<S> = void Function(Event<S> event);
