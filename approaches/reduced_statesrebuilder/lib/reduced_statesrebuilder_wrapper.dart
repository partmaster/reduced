// statesrebuilder_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/functions.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'reduced_statesrebuilder.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initializer) => Store(initialState),
      initializer: initialState,
      child: child,
    );

extension WrapWithConsumer<S> on Store<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      _ReactiveStatelessBuilder(
        builder: (_) => OnBuilder<S>(
          listenTo: value,
          shouldRebuild: (p0, p1) => _shouldRebuild(
            p0.data as S,
            p1.data as S,
            reducible.reduce,
            transformer,
          ),
          builder: () => builder(props: transformer(reducible)),
        ),
      );
}

class _ReactiveStatelessBuilder extends ReactiveStatelessWidget {
  const _ReactiveStatelessBuilder({required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

P _stateToProps<S, P>(
  S state,
  Reduce<S> reduce,
  ReducibleTransformer<S, P> transformer,
) =>
    transformer(ReducibleProxy(() => state, reduce, reduce));

bool _shouldRebuild<S, P>(
  S p0,
  S p1,
  Reduce<S> reduce,
  ReducibleTransformer<S, P> transformer,
) =>
    _stateToProps(p0, reduce, transformer) !=
    _stateToProps(p1, reduce, transformer);
