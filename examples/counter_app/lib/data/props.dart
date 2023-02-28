// props.dart

import 'package:reduced/callbacks.dart';

class MyHomePageProps {
  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  final String title;
  final VoidCallable onIncrementPressed;

  @override
  get hashCode => Object.hash(title, onIncrementPressed);

  @override
  operator ==(other) =>
      other is MyHomePageProps &&
      title == other.title &&
      onIncrementPressed == other.onIncrementPressed;
}

class MyCounterWidgetProps {
  const MyCounterWidgetProps({
    required this.counterText,
  });

  final String counterText;

  @override
  get hashCode => counterText.hashCode;

  @override
  operator ==(other) =>
      other is MyCounterWidgetProps &&
      counterText == other.counterText;
}
