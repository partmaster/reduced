// setstate_reduceable.dart

import 'package:flutter/material.dart';
import 'package:reduceable/inherited_value_widget.dart';

typedef ValueBuilder<V, S> = V Function(S initializer);

class StatefulInheritedValueWidget<V, S> extends StatefulWidget {
  const StatefulInheritedValueWidget({
    super.key,
    required this.builder,
    required this.initializer,
    required this.child,
  });

  final ValueBuilder<V, S> builder;
  final S initializer;
  final Widget child;

  @override
  State<StatefulInheritedValueWidget> createState() =>
      _StatefulInheritedValueWidgetState<V, S>(builder(initializer));
}

class _StatefulInheritedValueWidgetState<V, S>
    extends State<StatefulInheritedValueWidget<V, S>> {
  _StatefulInheritedValueWidgetState(this.value);

  final V value;

  @override
  Widget build(BuildContext context) => InheritedValueWidget(
        value: value,
        child: widget.child,
      );
}
