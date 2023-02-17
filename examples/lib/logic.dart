// logic.dart

import 'package:reducible/reducible.dart';

import 'props.dart';
import 'state.dart';

extension MyHomePagePropsExtension on Reducible<MyAppState> {
  MyHomePageProps get myHomePageProps => MyHomePageProps(
        title: getState().title,
        onIncrementPressed: BondedReducer(
          this,
          IncrementCounterReducer(),
        ),
      );
}

extension MyCounterWidgetPropsExtension on Reducible<MyAppState> {
  MyCounterWidgetProps get myCounterWidgetProps => MyCounterWidgetProps(
        counterText: '${getState().counter}',
      );
}

class IncrementCounterReducer extends Reducer<MyAppState> {
  IncrementCounterReducer._();
  factory IncrementCounterReducer() => instance;

  static final instance = IncrementCounterReducer._();

  @override
  MyAppState call(state) => state.copyWith(counter: state.counter + 1);
}
