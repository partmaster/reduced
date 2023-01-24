import 'package:flutter/material.dart';

import 'model.dart';
import 'util.dart';

class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final reduceableState =
        InheritedReducableState.of<MyAppState>(context);
    final props = MyHomePagePropsConverter.convert(reduceableState);
    return MyHomePageLayout(props: props);
  }
}

class MyHomePageLayout extends StatelessWidget {
  const MyHomePageLayout({
    Key? key,
    required this.props,
  }) : super(key: key);

  final MyHomePageProps props;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(props.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            MyCounterWidgetBuilder(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onIncrementPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyCounterWidgetBuilder extends StatelessWidget {
  const MyCounterWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final reduceableState =
        InheritedReducableState.of<MyAppState>(context);
    final props = MyCounterWidgetPropsConverter.convert(reduceableState);
    return MyCounterWidgetLayout(props: props);
  }
}

class MyCounterWidgetLayout extends StatelessWidget {
  const MyCounterWidgetLayout({
    Key? key,
    required this.props,
  }) : super(key: key);

  final MyCounterWidgetProps props;

  @override
  Widget build(BuildContext context) {
    return Text(
      props.counterText,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
