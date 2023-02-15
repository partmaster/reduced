// domain.dart

import 'reduceable.dart';

class MyAppState {
  const MyAppState({required this.title, this.counter=0});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );

  @override
  int get hashCode => Object.hash(title, counter);

  @override
  bool operator ==(Object other) =>
      other is MyAppState &&
      title == other.title &&
      counter == other.counter;

      @override
  String toString() => 'MyAppState#$hashCode(counter=$counter)';
}

class MyHomePageProps {
  final String title;
  final Callable onIncrementPressed;

  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  MyHomePageProps.reduceable(Reduceable<MyAppState> reduceable)
      : title = reduceable.state.title,
        onIncrementPressed = Action(
          reduceable,
          IncrementCounterReducer(),
        );

  @override
  int get hashCode => Object.hash(title, onIncrementPressed);

  @override
  bool operator ==(Object other) =>
      other is MyHomePageProps &&
      title == other.title &&
      onIncrementPressed == other.onIncrementPressed;

  @override
  String toString() => 'MyHomePageProps#$hashCode';
}

class MyCounterWidgetProps {
  final String counterText;

  const MyCounterWidgetProps({
    required this.counterText,
  });

  MyCounterWidgetProps.reduceable(Reduceable<MyAppState> reduceable)
      : counterText = '${reduceable.state.counter}';

  @override
  int get hashCode => counterText.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyCounterWidgetProps &&
      counterText == other.counterText;

  @override
  String toString() => 'MyCounterWidgetProps#$hashCode(counterText=$counterText)';
}

class IncrementCounterReducer extends Reducer<MyAppState> {
  IncrementCounterReducer._();
  factory IncrementCounterReducer() => instance;

  static final instance = IncrementCounterReducer._();

  @override
  MyAppState call(state) =>
      state.copyWith(counter: state.counter + 1);
}
