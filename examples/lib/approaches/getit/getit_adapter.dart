// getit_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reducible/reducible.dart';

import 'getit_reducible.dart';

Widget stateProviderAdapter<S>({
  required S initialState,
  required Widget child,
}) {
  GetIt.instance.registerSingleton<ValueNotifier<S>>(
    ValueNotifier<S>(initialState),
  );
  return child;
}

Widget stateConsumerAdapter<S, P>({
  required P Function(Reducible<S>) converter,
  required Widget Function({required P props}) builder,
}) =>
    StateConsumerAdapter(
      builder: builder,
      converter: converter,
    );

class StateConsumerAdapter<S, P> extends StatelessWidget with GetItMixin {
  final P Function(Reducible<S>) converter;
  final Widget Function({required P props}) builder;

  StateConsumerAdapter({
    super.key,
    required this.converter,
    required this.builder,
  });

  @override
  Widget build(context) => builder(
        props: watchOnly(
          (ValueNotifier<S> notifier) => converter(notifier.reducible),
        ),
      );
}
