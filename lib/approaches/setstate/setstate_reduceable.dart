// setstate_reduceable.dart

import 'package:flutter/material.dart';

import '../../reduceable.dart';

typedef ReduceableWidgetBuilder<S> = Widget Function(
  Reduceable<S> value,
  Widget child,
);

class ReduceableStatefulWidget<S> extends StatefulWidget {
  const ReduceableStatefulWidget({
    super.key,
    required this.initialState,
    required this.child,
    required this.builder,
  });

  final S initialState;
  final Widget child;
  final ReduceableWidgetBuilder<S> builder;

  @override
  State<ReduceableStatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ReduceableStatefulWidgetState<S>(initialState);
}

class _ReduceableStatefulWidgetState<S> extends State<ReduceableStatefulWidget<S>> {
  _ReduceableStatefulWidgetState(S initialState) : _state = initialState;

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
