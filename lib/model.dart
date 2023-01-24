import 'dart:ui' show VoidCallback;

import 'util.dart';

class MyAppState {
  const MyAppState({required this.title, required this.counter});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );
}

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

class IncrementCounterReducer {
  MyAppState call(MyAppState state, void _) =>
      state.copyWith(counter: state.counter + 1);
}
