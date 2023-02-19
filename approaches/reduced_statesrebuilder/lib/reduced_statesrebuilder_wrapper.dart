// statesrebuilder_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_typedefs.dart';
import 'package:reduced/inherited_value_widget.dart';
import 'reduced_statesrebuilder.dart';

Widget wrapWithProvider<S>({
  required Store<S> store,
  required Widget child,
}) =>
    InheritedValueWidget(
      value: store,
      child: child,
    );

extension WrapWithConsumer<S> on Store<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      _ReactiveStatelessBuilder(
        builder: (_) => OnBuilder<S>(
          listenTo: value,
          shouldRebuild: (p0, p1) => _shouldRebuild(
            p0.data as S,
            p1.data as S,
            reducible.reduce,
            converter,
          ),
          builder: () => builder(props: converter(reducible)),
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
  ReducibleConverter<S, P> converter,
) =>
    converter(Reducible(() => state, reduce, reduce));

bool _shouldRebuild<S, P>(
  S p0,
  S p1,
  Reduce<S> reduce,
  ReducibleConverter<S, P> converter,
) =>
    _stateToProps(p0, reduce, converter) !=
    _stateToProps(p1, reduce, converter);
