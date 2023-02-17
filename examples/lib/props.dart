// props.dart

import 'package:reducible/reducible.dart';

import 'logic.dart';
import 'state.dart';

class MyHomePageProps {
  final String title;
  final Callable onIncrementPressed;

  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  factory MyHomePageProps.reducible(Reducible<MyAppState> reducible) =>
      reducible.myHomePageProps;

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

  factory MyCounterWidgetProps.reducible(Reducible<MyAppState> reducible) =>
      reducible.myCounterWidgetProps;

  @override
  int get hashCode => counterText.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyCounterWidgetProps && counterText == other.counterText;

  @override
  String toString() =>
      'MyCounterWidgetProps#$hashCode(counterText=$counterText)';
}
