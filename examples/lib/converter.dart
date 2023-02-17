// converter.dart

import 'package:reducible/reducible.dart';

import 'props.dart';
import 'reducer.dart';
import 'state.dart';

extension MyHomePagePropsConverter on Reducible<MyAppState> {
  MyHomePageProps get myHomePageProps => MyHomePageProps(
        title: getState().title,
        onIncrementPressed: BondedReducer(
          this,
          IncrementCounterReducer(),
        ),
      );
}

extension MyCounterWidgetPropsConverter on Reducible<MyAppState> {
  MyCounterWidgetProps get myCounterWidgetProps => MyCounterWidgetProps(
        counterText: '${getState().counter}',
      );
}
