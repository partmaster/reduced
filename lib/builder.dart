import 'package:flutter/material.dart';

import 'model.dart';
import 'binder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePageBinder(),
    );
  }
}

class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key, required this.props});

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
            MyCounterWidgetBinder(),
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
  const MyCounterWidgetBuilder({super.key, required this.props});

  final MyCounterWidgetProps props;

  @override
  Widget build(BuildContext context) {
    return Text(
      props.counterText,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
