import 'package:flutter/material.dart';

typedef Reducer<S, V> = S Function(S, V);
typedef Reduce<S> = void Function<V>(Reducer<S, V>, V);

class ReduceableState<S> {
  ReduceableState(this.state, this.reduce);

  final S state;
  final Reduce<S> reduce;
}

class InheritedReducableState<S> extends InheritedWidget {
  const InheritedReducableState({
    super.key,
    required super.child,
    required this.value,
  });

  final ReduceableState<S> value;

  static ReduceableState<T> of<T>(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<InheritedReducableState<T>>();
    return inherited!.value;
  }

  @override
  bool updateShouldNotify(InheritedReducableState oldWidget) =>
      value != oldWidget.value;
}

class StateProvider<S> extends StatefulWidget {
  const StateProvider({super.key, required this.state, required this.child});

  final S state;
  final Widget child;

  @override
  State<StateProvider> createState() => _StateProviderState<S>(state);
}

class _StateProviderState<S> extends State<StateProvider<S>> {
  _StateProviderState(S state) : _state = state;

  S _state;

  void reduce<V>(Reducer<S, V> reducer, V value) {
    setState(() => _state = reducer(_state, value));
  }

  @override
  Widget build(BuildContext context) => InheritedReducableState(
        value: ReduceableState(_state, reduce),
        child: widget.child,
      );
}
