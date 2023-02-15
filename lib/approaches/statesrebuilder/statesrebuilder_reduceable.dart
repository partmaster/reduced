// statesrebuilder_reduceable.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../inherited_value_widget.dart';
import '../../reduceable.dart';

typedef StateToPropsConverter<S, P> = P Function(Reduceable<S>);

@immutable
class Store<S> {
  Store(S intitialValue) : value = RM.inject<S>(() => intitialValue);

  final Injected<S> value;

  S getState() => value.state;

  void reduce(Reducer<S> reducer) =>
      value.state = reducer(value.state);

  late final Reduceable<S> reduceable =
      Reduceable(getState, reduce, this);
}

extension StoreOnBuildContext on BuildContext {
  Store<S> store<S>() => InheritedValueWidget.of<Store<S>>(this);
}

extension BuildWidgetExtension<S> on Store<S> {
  Widget buildWidget<P>({
    required P Function(Reduceable<S>) converter,
    required Widget Function({Key? key, required P props}) builder,
  }) =>
      OnBuilder<S>(
        listenTo: value,
        shouldRebuild: (p0, p1) => _shouldRebuild(
          p0.data as S,
          p1.data as S,
          reduceable.reduce,
          converter,
        ),
        builder: () => builder(props: converter(reduceable)),
      );
}

P _stateToProps<S, P>(
  S state,
  Reduce<S> reduce,
  StateToPropsConverter<S, P> converter,
) =>
    converter(Reduceable(() => state, reduce, reduce));

bool _shouldRebuild<S, P>(
  S p0,
  S p1,
  Reduce<S> reduce,
  StateToPropsConverter<S, P> converter,
) =>
    _stateToProps(p0, reduce, converter) !=
    _stateToProps(p1, reduce, converter);
