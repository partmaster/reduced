// mappers.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'events.dart';
import 'state.dart';

class MyHomePagePropsMapper extends MyHomePageProps {
  MyHomePagePropsMapper(
    StoreSnapshot<MyAppState> snapshot,
    String? routeName,
  ) : super(
          onPressed: Command(snapshot.processor, CounterIncremented.instance),
          title: snapshot.state.title,
        );
}

class MyCounterWidgetPropsMapper extends MyCounterWidgetProps {
  MyCounterWidgetPropsMapper(
    StoreSnapshot<MyAppState> snapshot,
    String? routeName,
  ) : super(
          counterText: '${snapshot.state.counter}',
        );
}
