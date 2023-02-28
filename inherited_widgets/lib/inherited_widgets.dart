library inherited_widgets;

import 'package:flutter/widgets.dart';

class InheritedValueWidget<V> extends InheritedWidget {
  const InheritedValueWidget({
    super.key,
    required super.child,
    required this.value,
  });

  final V value;

  static U of<U>(BuildContext context) =>
      _widgetOf<InheritedValueWidget<U>>(context).value;

  static W _widgetOf<W extends InheritedValueWidget>(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<W>();
    if (result == null) {
      throw AssertionError('InheritedValueWidget._widgetOf<$W> return null');
    }
    return result;
  }

  @override
  bool updateShouldNotify(InheritedValueWidget oldWidget) =>
      value != oldWidget.value;
}

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
      // ignore: no_logic_in_create_state
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
