// domain.dart

import 'package:quiver/core.dart';

import 'reduceable.dart';

class MyAppState {
  const MyAppState({required this.title, required this.counter});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );

  @override
  int get hashCode => hash2(title, counter);

  @override
  bool operator ==(Object other) =>
      other is MyAppState &&
      title == other.title &&
      counter == other.counter;
}

class MyHomePageProps {
  final String title;
  final Callable<void> onIncrementPressed;

  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  MyHomePageProps.reduceable(Reduceable<MyAppState> reduceable)
      : title = reduceable.state.title,
        onIncrementPressed = VoidCallable(
          reduceable,
          IncrementCounterReducer(),
        ) {
    print(
        'MyHomePageProps(onIncrementPressed.hashCode=${onIncrementPressed.hashCode}) => $hashCode');
  }

  @override
  int get hashCode => hash2(title, onIncrementPressed);

  @override
  bool operator ==(Object other) =>
      other is MyHomePageProps &&
      title == other.title &&
      onIncrementPressed == other.onIncrementPressed;
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
}

class IncrementCounterReducer extends Reducer<MyAppState> {
  IncrementCounterReducer._();
  factory IncrementCounterReducer() => instance;

  static final instance = IncrementCounterReducer._();

  @override
  MyAppState call(state) =>
      state.copyWith(counter: state.counter + 1);
}
