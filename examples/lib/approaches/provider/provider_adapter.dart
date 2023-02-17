// provider_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reducible/reducible.dart';

import 'provider_reducible.dart';

Widget stateProviderAdapter<S>({
  required S initialState,
  required Widget child,
}) =>
    ChangeNotifierProvider<ValueNotifier<S>>(
      create: (context) => ValueNotifier<S>(initialState),
      child: child,
    );

Widget stateConsumerAdapter<S, P>({
  required P Function(Reducible<S>) converter,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    Selector<ValueNotifier<S>, P>(
      builder: (context, props, _) => builder(props: props),
      selector: (context, notifier) => converter(notifier.reducible),
    );
