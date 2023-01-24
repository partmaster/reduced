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
    return MyHomePageRenderer(props: props);
  }
}

class MyHomePageRenderer extends StatelessWidget {
  const MyHomePageRenderer({
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
    return MyCounterWidgetRenderer(props: props);
  }
}

class MyCounterWidgetRenderer extends StatelessWidget {
  const MyCounterWidgetRenderer({
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
