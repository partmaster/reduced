// reduced_mobx.dart

library reduced_mobx;

import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_functions.dart';

part 'reduced_mobx.g.dart';

class ReducibleStore<S, P1, P2> = ReducibleStoreBase<S, P1, P2>
    with _$ReducibleStore;

abstract class ReducibleStoreBase<S, P1, P2> extends Reducible<S>
    with Store {
  ReducibleStoreBase(
    this.value,
    this.transformer1,
    this.transformer2,
  );

  final ReducibleTransformer<S, P1> transformer1;
  final ReducibleTransformer<S, P2> transformer2;

  @observable
  S value;

  @override
  S get state => value;

  @override
  @action
  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  late final Reducible<S> reducible = this;

  @computed
  P1 get p1 => transformer1(reducible);

  @computed
  P2 get p2 => transformer2(reducible);
}

extension ExtensionStoreOnBuildContext on BuildContext {
  ReducibleStore<S, P1, P2> store<S, P1, P2>() =>
      InheritedValueWidget.of<ReducibleStore<S, P1, P2>>(this);
}
