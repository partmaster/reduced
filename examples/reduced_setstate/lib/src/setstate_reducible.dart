// setstate_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

typedef ReducibleWidgetBuilder<S> = Widget Function(
  Reducible<S> reducible,
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
      _ReducibleStatefulWidgetState<S>();
}

class _ReducibleStatefulWidgetState<S> extends State<ReducibleStatefulWidget<S>>
    implements Reducible<S> {
  late S _state;

  @override
  initState() => _state = widget.initialState;

  @override
  S get state => _state;

  @override
  reduce(reducer) => setState(() => _state = reducer(_state));

  @override
  build(context) => widget.builder(this, widget.child);
}
