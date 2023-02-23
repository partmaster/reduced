// transformer.dart

import 'package:reduced/reduced.dart';

import '../data/props.dart';
import '../data/state.dart';
import 'reducer.dart';

class MyHomePagePropsTransformer {
  static MyHomePageProps transform(Reducible<MyAppState> reducible) =>
      MyHomePageProps(
        title: reducible.getState().title,
        onIncrementPressed: reducible.incrementCounterReducer,
      );
}

class MyCounterWidgetPropsTransformer {
  static MyCounterWidgetProps transform(Reducible<MyAppState> reducible) =>
      MyCounterWidgetProps(
        counterText: '${reducible.getState().counter}',
      );
}
