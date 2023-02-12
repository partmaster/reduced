import 'package:counter_app/domain.dart';
import 'package:mobx/mobx.dart';

import '../reduceable.dart';

part 'mobx.g.dart';

final store = MyStore();

class MyStore = MyStoreBase with _$MyStore;

abstract class MyStoreBase with Store {
  @observable
  MyAppState value = const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );

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
