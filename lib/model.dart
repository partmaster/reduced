import 'dart:ui' show VoidCallback;

import 'reduceable_state.dart';

class MyAppState {
  const MyAppState({required this.title, required this.counter});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );
}

class IncrementCounterReducer {
  MyAppState call(MyAppState state, void _) =>
      state.copyWith(counter: state.counter + 1);
}

class MyHomePageProps {
  final String title;
  final VoidCallback onIncrementPressed;

  MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  factory MyHomePageProps.fromState(
    ReduceableState<MyAppState> reduceableState,
  ) =>
      MyHomePageProps(
        title: reduceableState.state.title,
        onIncrementPressed: () =>
            reduceableState.reduce(IncrementCounterReducer(), null),
      );
}

class MyCounterWidgetProps {
  final String counterText;

  MyCounterWidgetProps({
    required this.counterText,
  });

  factory MyCounterWidgetProps.fromState(
    ReduceableState<MyAppState> reduceableState,
  ) =>
      MyCounterWidgetProps(
        counterText: '${reduceableState.state.counter}',
      );
}
