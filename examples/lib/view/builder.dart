// builder.dart

import 'package:examples/data/props.dart';
import 'package:flutter/material.dart';

import 'binder.dart';

class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key, required this.props});

  final MyHomePageProps props;

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: Text(props.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  const <Widget>[
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

class MyCounterWidgetBuilder extends StatelessWidget {
  const MyCounterWidgetBuilder({super.key, required this.props});

  final MyCounterWidgetProps props;

  @override
  Widget build(context) => Text(
        props.counterText,
        style: Theme.of(context).textTheme.headlineMedium,
      );
}

class MyAppBuilder extends StatelessWidget {
  const MyAppBuilder({super.key});

  @override
  Widget build(context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePageBinder(),
      );
}
