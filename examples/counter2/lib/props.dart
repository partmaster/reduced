// props.dart

import 'package:reduced/reduced.dart';

class MyHomePageProps {
  MyHomePageProps({
    required this.onPressed,
    required this.title,
  });

  final String title;
  final Callable<void> onPressed;
}

class MyCounterWidgetProps {
  MyCounterWidgetProps({
    required this.counterText,
  });

  final String counterText;
}
