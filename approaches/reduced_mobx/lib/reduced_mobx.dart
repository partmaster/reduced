// reduced_mobx.dart

library reduced_mobx;

import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_typedefs.dart';

part 'reduced_mobx.g.dart';

class ReducibleStore<S, P1, P2> = ReducibleStoreBase<S, P1, P2>
    with _$ReducibleStore;

abstract class ReducibleStoreBase<S, P1, P2> with Store {
  ReducibleStoreBase(this.value, this.converter1, this.converter2);

  final ReducibleConverter<S, P1> converter1;
  final ReducibleConverter<S, P2> converter2;

  @observable
  S value;

  S getState() => value;

  @action
  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  late final Reducible<S> reducible = Reducible(getState, reduce, this);

  @computed
  P1 get p1 => converter1(reducible);

  @computed
  P2 get p2 => converter2(reducible);
}

extension ExtensionStoreOnBuildContext on BuildContext {
  ReducibleStore<S, P1, P2> store<S, P1, P2>() =>
      InheritedValueWidget.of<ReducibleStore<S, P1, P2>>(this);
}
