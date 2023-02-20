// mock_reducible.dart

import 'package:examples/data/props.dart';
import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/reduced.dart';


class MyMockProps {
  final MyHomePageProps myHomePageProps;
  final MyCounterWidgetProps counterWidgetProps;

  MyMockProps({
    required String title,
    required Callable onIncrementPressed,
    required String counterText,
  })  : myHomePageProps = MyHomePageProps(
          title: title,
          onIncrementPressed: onIncrementPressed,
        ),
        counterWidgetProps = MyCounterWidgetProps(
          counterText: counterText,
        );
}

extension ExtensionMockOnBuildContext on BuildContext {
  MyMockProps get mock => InheritedValueWidget.of<MyMockProps>(this);
}

class MockCallable extends Callable {
  int count = 0;
  
  @override
  void call() => ++count;
}
