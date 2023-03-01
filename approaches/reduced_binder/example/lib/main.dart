// main.dart

import 'package:flutter/material.dart';
import 'package:binder/binder.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/callbacks.dart';
import 'package:reduced_binder/reduced_binder.dart';
import 'package:reduced_binder/reduced_binder_wrapper.dart';

class Incrementer extends Reducer<int> {
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counter, required this.onPressed});
  final String counter;
  final Callable<void> onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      counter: '${reducible.state}',
      onPressed: ReducerOnReducible(reducible, Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: const Text('reduced_binder example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text('${props.counter}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );

final stateRef = StateRef(0);
final logicRef = LogicRef((scope) => ReducibleLogic(scope, stateRef));

void main() => runApp(
      wrapWithScope(
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) =>
                context.logic(logicRef).wrapWithConsumer(
                      stateRef: stateRef,
                      transformer: transformer,
                      builder: builder,
                    ),
          ),
        ),
      ),
    );
