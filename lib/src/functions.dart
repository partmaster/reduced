// functions.dart

import 'package:flutter/widgets.dart' show Key, Widget;

import 'store.dart';

/// A function that transforms a ReducedStore to another type.
///
/// The type parameter `S` is the type of the state of the [ReducedStore].
/// The type parameter `P` is the return type of the function.
typedef ReducedTransformer<S, P> = P Function(ReducedStore<S>);

// A function that builds a Widget from a property parameter.
///
/// The type parameter `P` is the type of the parameter.
typedef ReducedWidgetBuilder<P> = Widget Function({
  Key? key,
  required P props,
});
