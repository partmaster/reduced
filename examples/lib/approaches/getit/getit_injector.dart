// getit_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reducible/reducible.dart';

import 'getit_reducible.dart';

Widget injectStateProvider<S>({
  required S initialState,
  required Widget child,
}) {
  GetIt.instance.registerSingleton<ValueNotifier<S>>(
    ValueNotifier<S>(initialState),
  );
  return child;
}

Widget injectStateConsumer<S, P>({
  required ReducibleConverter<S, P> converter,
  required Widget Function({required P props}) builder,
}) =>
    _InjectStateConsumer(
      builder: builder,
      converter: converter,
    );

class _InjectStateConsumer<S, P> extends StatelessWidget with GetItMixin {
  final ReducibleConverter<S, P> converter;
  final Widget Function({required P props}) builder;

  _InjectStateConsumer({
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
