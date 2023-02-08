import 'package:counter_app/domain.dart';
import 'package:flutter/widgets.dart';

import '../reduceable.dart';
import '../setstate/setstate.dart';

class MyMockProps {
  final MyHomePageProps myHomePageProps;
  final MyCounterWidgetProps counterWidgetProps;

  MyMockProps({
    required String title,
    required Callable<void> onIncrementPressed,
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

class MockCallable extends Callable<void> {
  int count = 0;
  
  @override
  void call() => ++count;
}
