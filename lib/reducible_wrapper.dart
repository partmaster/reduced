import 'package:flutter/widgets.dart';
import 'package:reducible/reducible.dart';

/// A function that converts a Reducible to another type. 
/// The type parameter `S` is the type of the state of the [Reducible].
/// The type parameter `P` is the return type of function.
typedef ReducibleConverter<S, P> = P Function(Reducible<S>);

// A function that builds a Widget from a property parameter.
/// The type parameter `P` is the type of the parameter.
typedef PropsWidgetBuilder<P> = Widget Function({Key? key, required P props});
