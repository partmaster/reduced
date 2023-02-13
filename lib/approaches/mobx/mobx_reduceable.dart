// mobx_reduceable.dart

import 'package:mobx/mobx.dart';

import '../../domain.dart';
import '../../reduceable.dart';

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
