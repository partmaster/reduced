// mobx_reducible.dart

import 'package:mobx/mobx.dart';
import 'package:reducible/reducible.dart';

import '../../data/props.dart';
import '../../data/state.dart';

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
