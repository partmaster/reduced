import 'package:flutter/widgets.dart';

import 'model.dart';
import 'stateful_widgets.dart';
import 'view.dart';

void main() {
  const state = MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  const app = MyApp();
  const provider = MyProvider(state: state, app: app);
  runApp(provider);
}

class MyProvider extends StatelessWidget {
  const MyProvider({Key? key, required this.state, required this.app})
      : super(key: key);

  final MyAppState state;
  final Widget app;

  @override
  Widget build(BuildContext context) => StateProvider(
        state: state,
        child: app,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePageProps.fromState(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetProps.fromState(value),
            child: child,
          ),
        ),
      );
}

class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key});

  @override
  Widget build(context) => MyHomePageRenderer(
        props: InheritedValueWidget.of<MyHomePageProps>(context),
      );
}

class MyCounterWidgetBuilder extends StatelessWidget {
  const MyCounterWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) => MyCounterWidgetRenderer(
        props: InheritedValueWidget.of<MyCounterWidgetProps>(context),
      );
}
