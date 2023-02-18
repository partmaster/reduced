// provider_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../typedefs.dart';
import 'provider_reducible.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    ChangeNotifierProvider<ValueNotifier<S>>(
      create: (context) => ValueNotifier<S>(initialState),
      child: child,
    );

Widget wrapWithConsumer<S, P>({
  required ReducibleConverter<S, P> converter,
  required PropsWidgetBuilder<P> builder,
}) =>
    Selector<ValueNotifier<S>, P>(
      builder: (context, props, _) => builder(props: props),
      selector: (context, notifier) => converter(notifier.reducible),
    );
