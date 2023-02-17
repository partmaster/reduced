// converter.dart

import 'package:reducible/reducible.dart';

import '../data/props.dart';
import '../data/state.dart';
import 'reducer.dart';

class MyHomePagePropsConverter {
  static MyHomePageProps convert(Reducible<MyAppState> reducible) =>
      MyHomePageProps(
        title: reducible.getState().title,
        onIncrementPressed: BondedReducer(
          reducible,
          IncrementCounterReducer(),
        ),
      );
}

class MyCounterWidgetPropsConverter {
  static MyCounterWidgetProps convert(Reducible<MyAppState> reducible) =>
      MyCounterWidgetProps(
        counterText: '${reducible.getState().counter}',
      );
}
