// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_bloc/reduced_bloc.dart';
import 'package:reduced_bloc/reduced_bloc_wrapper.dart';

class Incrementer extends Reducer<int> {
  int call(int state) => state + 1;
}

class Props {
  Props(this.counter, this.onPressed);
  final String counter;
  final VoidCallback onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      '${reducible.state}',
      () => reducible.reduce(Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: Text('reduced_bloc example')),
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

void main() => runApp(
      wrapWithProvider(
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) =>
                context.bloc<int>().wrapWithConsumer(
                      transformer: transformer,
                      builder: builder,
                    ),
          ),
        ),
      ),
    );
