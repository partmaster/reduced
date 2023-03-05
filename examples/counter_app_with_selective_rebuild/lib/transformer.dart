// transformer.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'reducer.dart';
import 'state.dart';

MyHomePageProps transformMyHomePageProps(
  Reducible<MyAppState> reducible,
) =>
    MyHomePageProps(
      onPressed: CallableAdapter(reducible, Incrementer.instance),
      title: reducible.state.title,
    );

MyCounterWidgetProps transformMyCounterWidgetProps(
  Reducible<MyAppState> reducible,
) =>
    MyCounterWidgetProps(
      counterText: '${reducible.state.counter}',
    );
