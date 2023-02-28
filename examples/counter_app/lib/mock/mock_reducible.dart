// mock_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced/callbacks.dart';

import '../data/props.dart';

class MyMockProps {
  final MyHomePageProps myHomePageProps;
  final MyCounterWidgetProps counterWidgetProps;

  MyMockProps({
    required String title,
    required VoidCallable onIncrementPressed,
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

class MockCallable extends VoidCallable {
  int count = 0;

  @override
  void call() => ++count;
}
