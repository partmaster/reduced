import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const state = MyAppState(
      title: 'Flutter Demo Home Page',
      counter: 0,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StateProvider(state: state, child: MyHomePageBuilder()),
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

typedef Reducer<S, V> = S Function(S, V);
typedef Reduce<S> = void Function<V>(Reducer<S, V>, V);

class MyHomePageProps {
  final String title;
  final String counterText;
  final VoidCallback onIncrementPressed;

  MyHomePageProps({
    required this.title,
    required this.counterText,
    required this.onIncrementPressed,
  });
}

class MyHomePagePropsConverter {
  static MyHomePageProps convert(ReduceableState<MyAppState> reduceableState) =>
      MyHomePageProps(
        title: reduceableState.state.title,
        counterText: '${reduceableState.state.counter}',
        onIncrementPressed: () =>
            reduceableState.reduce(IncrementCounterReducer(), null),
      );
}

class ReduceableState<S> {
  ReduceableState(this.state, this.reduce);

  final S state;
  final Reduce<S> reduce;
}

class InheritedReducableState<S> extends InheritedWidget {
  const InheritedReducableState({
    super.key,
    required super.child,
    required this.value,
  });

  final ReduceableState<S> value;

  static ReduceableState<T> of<T>(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<InheritedReducableState<T>>();
    return inherited!.value;
  }

  @override
  bool updateShouldNotify(InheritedReducableState oldWidget) =>
      value != oldWidget.value;
}

class IncrementCounterReducer {
  MyAppState call(MyAppState state, void _) =>
      state.copyWith(counter: state.counter + 1);
}

class StateProvider<S> extends StatefulWidget {
  const StateProvider({super.key, required this.state, required this.child});

  final S state;
  final Widget child;

  @override
  State<StateProvider> createState() => _StateProviderState<S>(state);
}

class _StateProviderState<S> extends State<StateProvider<S>> {
  _StateProviderState(S state) : _state = state;

  S _state;

  void reduce<V>(Reducer<S, V> reducer, V value) {
    setState(() => _state = reducer(_state, value));
  }

  @override
  Widget build(BuildContext context) => InheritedReducableState(
        value: ReduceableState(_state, reduce),
        child: widget.child,
      );
}

class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final reduceableState = InheritedReducableState.of<MyAppState>(context);
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
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              props.counterText,
              style: Theme.of(context).textTheme.headline4,
            ),
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
