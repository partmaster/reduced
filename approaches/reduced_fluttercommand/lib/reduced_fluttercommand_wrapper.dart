// fluttercommand_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:reduced/reduced_typedefs.dart';
import 'package:reduced/stateful_inherited_value_widget.dart';

import 'reduced_fluttercommand.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    StatefulInheritedValueWidget(
      builder: (initialState) => ReducibleCommandStore(initialState),
      initializer: initialState,
      child: child,
    );

extension WrapWithConsumer<S> on ReducibleCommandStore<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleConverter<S, P> converter,
    required PropsWidgetBuilder<P> builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable: command.map((state) => converter(reducible)),
        builder: (_, props, ___) => builder(props: props),
      );
}
