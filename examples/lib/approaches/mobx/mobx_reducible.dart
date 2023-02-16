// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:reduceable/reducible.dart';

import '../../logic.dart';
import '../../util/inherited_value_widget.dart';

part 'mobx_reducible.g.dart';

class MyStore = MyStoreBase with _$MyStore;

abstract class MyStoreBase with Store {
  MyStoreBase(this.value);

  @observable
  MyAppState value;

  MyAppState getState() => value;

  @action
  void reduce(Reducer<MyAppState> reducer) {
    value = reducer(value);
  }

  late final Reducible<MyAppState> reducible =
      Reducible(getState, reduce, this);

  @computed
  MyHomePageProps get homePageProps =>
      MyHomePageProps.reducible(reducible);

  @computed
  MyCounterWidgetProps get conterWidgetProps =>
      MyCounterWidgetProps.reducible(reducible);
}

Widget binderWidget({
  required MyStore store,
  required Widget child,
}) =>
    InheritedValueWidget(value: store, child: child);

extension BuilderWidgetExtension on MyStore {
  Widget builderWidget<P>({
    required P Function(MyStore) props,
    required Widget Function({required P props}) builder,
  }) =>
      Observer(builder: (_) => builder(props: props(this)));
}
