// fluttercommand_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:reduced/reduced_functions.dart';
import 'package:inherited_widgets/inherited_widgets.dart';

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
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      ValueListenableBuilder<P>(
        valueListenable: command.map((state) => transformer(reducible)),
        builder: (_, props, ___) => builder(props: props),
      );
}
