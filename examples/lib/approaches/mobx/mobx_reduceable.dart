// mobx_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:reduceable/reduceable.dart';

import '../../logic.dart';
import '../../util/inherited_value_widget.dart';

part 'mobx_reduceable.g.dart';

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

  late final Reduceable<MyAppState> reduceable =
      Reduceable(getState, reduce, this);

  @computed
  MyHomePageProps get homePageProps =>
      MyHomePageProps.reduceable(reduceable);

  @computed
  MyCounterWidgetProps get conterWidgetProps =>
      MyCounterWidgetProps.reduceable(reduceable);
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
