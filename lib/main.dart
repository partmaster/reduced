import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MyAppState(title: 'Flutter Demo Home Page', counter: 0,);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(state: state),
    );
  }
}

class MyAppState {
  const MyAppState({required this.title, required this.counter});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.state});

  final MyAppState state;

  @override
  State<MyHomePage> createState() => _MyHomePageState(state);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(MyAppState state) : _state = state;
  MyAppState _state;

  void _incrementCounter() {
    setState(() {
      _state = _state.copyWith(counter: _state.counter + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_state.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_state.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
