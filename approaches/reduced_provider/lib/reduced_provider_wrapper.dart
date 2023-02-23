// provider_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reduced/reduced_functions.dart';

import 'reduced_provider.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    ChangeNotifierProvider<ValueNotifier<S>>(
      create: (context) => ValueNotifier<S>(initialState),
      child: child,
    );

Widget wrapWithConsumer<S, P>({
  required ReducibleTransformer<S, P> transformer,
  required PropsWidgetBuilder<P> builder,
}) =>
    Selector<ValueNotifier<S>, P>(
      builder: (context, props, _) => builder(props: props),
      selector: (context, notifier) => transformer(notifier.reducible),
    );
