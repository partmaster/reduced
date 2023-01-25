import 'package:flutter/material.dart';

import 'reduceable_state.dart';

typedef ReduceableStateWidgetBuilder<S> = Widget Function(
  ReduceableState<S> value,
  Widget child,
);

class InheritedValueWidget<P> extends InheritedWidget {
  const InheritedValueWidget({
    super.key,
    required super.child,
    required this.value,
  });

  final P value;

  static T of<T>(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<InheritedValueWidget<T>>();
    return inherited!.value;
  }

  @override
  bool updateShouldNotify(InheritedValueWidget oldWidget) =>
      value != oldWidget.value;
}

class StateProvider<S> extends StatefulWidget {
  const StateProvider({
    super.key,
    required this.state,
    required this.child,
    required this.builder,
  });

  final S state;
  final Widget child;
  final ReduceableStateWidgetBuilder<S> builder;

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
  Widget build(BuildContext context) => widget.builder(
        ReduceableState(_state, reduce),
        widget.child,
      );
}
