// fluttercommand_injector.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';

import '../../typedefs.dart';
import '../../widget/stateful_inherited_value_widget.dart';
import 'fluttercommand_reducible.dart';

Widget injectStateProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleCommandStore(initialState),
      initializer: initialState,
      child: child,
    );

extension InjectStateConsumer<S> on ReducibleCommandStore<S> {
  Widget injectStateConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable: command.map((state) => converter(reducible)),
        builder: (_, props, ___) => builder(props: props),
      );
}
