// inherited_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

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

typedef Converter<V, S> = V Function(S rawValue);

class StatefulInheritedValueWidget<V, S> extends StatefulWidget {
  const StatefulInheritedValueWidget({
    super.key,
    required this.converter,
    required this.rawValue,
    required this.child,
  });

  final Converter<V, S> converter;
  final S rawValue;
  final Widget child;

  @override
  State<StatefulInheritedValueWidget> createState() =>
      _StatefulInheritedValueWidgetState<V, S>();
}

class _StatefulInheritedValueWidgetState<V, S>
    extends State<StatefulInheritedValueWidget<V, S>> {
  late final V value;

  @override
  void initState() {
    value = widget.converter(widget.rawValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => InheritedValueWidget(
        value: value,
        child: widget.child,
      );
}

class StatefulValueWidget<V> extends StatefulWidget {
  const StatefulValueWidget({
    super.key,
    required this.value,
    required this.child,
  });

  final V value;
  final Widget child;

  @override
  State<StatefulValueWidget> createState() => _StatefulValueWidgetState<V>();
}

class _StatefulValueWidgetState<V> extends State<StatefulValueWidget<V>> {
  late final V value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ReducedStatefulBuilderWidget<V> extends StatefulWidget {
  const ReducedStatefulBuilderWidget({
    super.key,
    required this.builder,
  });

  final ReducedWidgetBuilder<V> builder;

  @override
  State<ReducedStatefulBuilderWidget> createState() =>
      _ReducedStatefulBuilderWidgetState<V>();
}

class _ReducedStatefulBuilderWidgetState<V>
    extends State<ReducedStatefulBuilderWidget<V>> {
  Widget? child;

  @override
  void didChangeDependencies() {
    child = null;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ReducedStatefulBuilderWidget<V> oldWidget) {
    if (widget.builder != oldWidget.builder) {
      child = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) =>
      child ??= widget.builder(props: InheritedValueWidget.of<V>(context));
}
