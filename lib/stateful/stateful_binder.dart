import 'package:flutter/widgets.dart';

import '../model.dart';
import 'stateful_util.dart';
import '../builder.dart';

class MyAppStateProvider extends StatelessWidget {
  const MyAppStateProvider({Key? key, required this.child})
      : super(key: key);

  final MyAppState state = const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  final Widget child;

  @override
  Widget build(BuildContext context) => StateProvider(
        state: state,
        child: child,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePageProps.fromState(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetProps.fromState(value),
            child: child,
          ),
        ),
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => MyHomePageBuilder(
        props: InheritedValueWidget.of<MyHomePageProps>(context),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(BuildContext context) => MyCounterWidgetBuilder(
        props: InheritedValueWidget.of<MyCounterWidgetProps>(context),
      );
}
