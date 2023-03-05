// setstate_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';
import 'setstate_reducible.dart';

class _ReducibleAndState<S> {
  _ReducibleAndState(this.reducible) : state = reducible.state;

  final Reducible<S> reducible;
  final S state;

  @override
  get hashCode => Object.hash(reducible, state);

  @override
  operator ==(other) =>
      other is ReducibleAndState &&
      state == other.state &&
      reducible == other.reducible;
}

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    ReducibleStatefulWidget(
      initialState: initialState,
      child: child,
      builder: (reducible, child) => InheritedValueWidget(
        value: _ReducibleAndState(reducible),
        child: child,
      ),
    );

Widget wrapWithConsumer<S, P extends Object>({
  required ReducedWidgetBuilder<P> builder,
  required ReducedTransformer<S, P> transformer,
}) =>
    Builder(
      builder: (context) => InheritedValueWidget(
        value: transformer(
            InheritedValueWidget.of<_ReducibleAndState<S>>(context).reducible),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      ),
    );
