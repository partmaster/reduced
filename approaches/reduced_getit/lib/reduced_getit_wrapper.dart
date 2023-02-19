// getit_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/reduced_typedefs.dart';

import 'reduced_getit.dart';

Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) {
  GetIt.instance.registerSingleton<ValueNotifier<S>>(
    ValueNotifier<S>(initialState),
  );
  return child;
}

Widget wrapWithConsumer<S, P>({
  required ReducibleConverter<S, P> converter,
  required PropsWidgetBuilder<P> builder,
}) =>
    _WrapWithConsumer(
      builder: builder,
      converter: converter,
    );

class _WrapWithConsumer<S, P> extends StatelessWidget with GetItMixin {
  final ReducibleConverter<S, P> converter;
  final PropsWidgetBuilder<P> builder;

  _WrapWithConsumer({
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
