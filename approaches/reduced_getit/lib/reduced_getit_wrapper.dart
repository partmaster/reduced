// getit_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/functions.dart';

import 'reduced_getit.dart';

void registerReducible<S>({required S initialState}) =>
    GetIt.instance.registerSingleton<ValueNotifier<S>>(
      ValueNotifier<S>(initialState),
    );

Widget wrapWithConsumer<S, P>({
  required ReducibleTransformer<S, P> transformer,
  required PropsWidgetBuilder<P> builder,
}) =>
    _WrapWithConsumer(
      builder: builder,
      transformer: transformer,
    );

class _WrapWithConsumer<S, P> extends StatelessWidget with GetItMixin {
  final ReducibleTransformer<S, P> transformer;
  final PropsWidgetBuilder<P> builder;

  _WrapWithConsumer({
    super.key,
    required this.transformer,
    required this.builder,
  });

  @override
  Widget build(context) => builder(
        props: watchOnly(
          (ValueNotifier<S> notifier) => transformer(notifier.reducible),
        ),
      );
}
