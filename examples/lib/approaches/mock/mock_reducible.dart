// mock_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:reducible/reducible.dart';

import '../../util/inherited_value_widget.dart';
import '../../logic.dart';

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

extension MockPropsOnBuildContext on BuildContext {
  MyMockProps get mock => InheritedValueWidget.of<MyMockProps>(this);
}

class MyMockPropsBinder extends StatelessWidget {
  const MyMockPropsBinder({
    super.key,
    required this.child,
    required this.props,
  });

  final Widget child;
  final MyMockProps props;

  @override
  Widget build(context) => InheritedValueWidget(
        value: props,
        child: child,
      );
}

class MockCallable extends Callable {
  int count = 0;
  
  @override
  void call() => ++count;
}
