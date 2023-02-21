// props.dart

import 'package:reduced/reduced.dart';

class MyHomePageProps {
  final String title;
  final Callable onIncrementPressed;

  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

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

  @override
  int get hashCode => counterText.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyCounterWidgetProps && counterText == other.counterText;

  @override
  String toString() =>
      'MyCounterWidgetProps#$hashCode(counterText=$counterText)';
}
