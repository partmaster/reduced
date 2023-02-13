// setstate_reduceable.dart

import 'package:flutter/material.dart';

import '../reduceable.dart';

typedef ReduceableWidgetBuilder<S> = Widget Function(
  Reduceable<S> value,
  Widget child,
);

class SetStateReduceable<S> extends StatefulWidget {
  const SetStateReduceable({
    super.key,
    required this.initialState,
    required this.child,
    required this.builder,
  });

  final S initialState;
  final Widget child;
  final ReduceableWidgetBuilder<S> builder;

  @override
  State<SetStateReduceable> createState() =>
      _SetStateReduceableState<S>(initialState);
}

class _SetStateReduceableState<S> extends State<SetStateReduceable<S>> {
  _SetStateReduceableState(S initialState) : _state = initialState;

  S _state;

  S getState() => _state;

  late final reduceable = Reduceable(getState, reduce, this);

  void reduce(Reducer<S> reducer) =>
      setState(() => _state = reducer(_state));

  @override
  Widget build(BuildContext context) => widget.builder(
        reduceable,
        widget.child,
      );
}

class InheritedValueWidget<V> extends InheritedWidget {
  const InheritedValueWidget({
    super.key,
    required super.child,
    required this.value,
  });

  final V value;

  static V of<V>(BuildContext context) =>
      _widgetOf<InheritedValueWidget<V>>(context).value;

  static W _widgetOf<W extends InheritedValueWidget>(
          BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<W>()!;

  @override
  bool updateShouldNotify(InheritedValueWidget oldWidget) =>
      value != oldWidget.value;
}
