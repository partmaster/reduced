// converter.dart

import 'package:reduced/reduced.dart';

import '../data/props.dart';
import '../data/state.dart';
import 'reducer.dart';

class MyHomePagePropsConverter {
  static MyHomePageProps convert(Reducible<MyAppState> reducible) =>
      MyHomePageProps(
        title: reducible.getState().title,
        onIncrementPressed: reducible.incrementCounterReducer,
      );
}

class MyCounterWidgetPropsConverter {
  static MyCounterWidgetProps convert(Reducible<MyAppState> reducible) =>
      MyCounterWidgetProps(
        counterText: '${reducible.getState().counter}',
      );
}
