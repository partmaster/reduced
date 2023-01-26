// domain.dart

import 'dart:ui' show VoidCallback;

import 'reduceable.dart';

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
  final VoidCallback onIncrementPressed;

  MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  MyHomePageProps.reduceable(Reduceable<MyAppState> reduceable)
      : title = reduceable.state.title,
        onIncrementPressed =
            (() => reduceable.reduce(IncrementCounterReducer()));
}

class MyCounterWidgetProps {
  final String counterText;

  MyCounterWidgetProps({
    required this.counterText,
  });

  MyCounterWidgetProps.reduceable(Reduceable<MyAppState> reduceable)
      : counterText = '${reduceable.state.counter}';
}

class IncrementCounterReducer extends Reducer<MyAppState> {
  @override
  MyAppState call(state) =>
      state.copyWith(counter: state.counter + 1);
}
