// reduced_setstate.dart

library reduced_setstate;

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

typedef ReducibleWidgetBuilder<S> = Widget Function(
  Reducible<S> value,
  Widget child,
);

class ReducibleStatefulWidget<S> extends StatefulWidget {
  const ReducibleStatefulWidget({
    super.key,
    required this.initialState,
    required this.child,
    required this.builder,
  });

  final S initialState;
  final Widget child;
  final ReducibleWidgetBuilder<S> builder;

  @override
  State<ReducibleStatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ReducibleStatefulWidgetState<S>(initialState);
}

class _ReducibleStatefulWidgetState<S>
    extends State<ReducibleStatefulWidget<S>> {
  _ReducibleStatefulWidgetState(S initialState) : _state = initialState;

  S _state;

  S getState() => _state;

  late final reducible = Reducible(getState, reduce, this);

  void reduce(Reducer<S> reducer) => setState(() => _state = reducer(_state));

  @override
  Widget build(BuildContext context) => widget.builder(
        reducible,
        widget.child,
      );
}
