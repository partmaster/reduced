// getit_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduceable/reduceable.dart';

extension ReduceableValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reduceable<S> get reduceable => Reduceable(getState, reduce, this);
}

Widget binderWidget<S>({
  required S initialState,
  required Widget child,
}) {
  GetIt.instance.registerSingleton<ValueNotifier<S>>(
    ValueNotifier<S>(initialState),
  );
  return child;
}

Widget builderWidget<S, P>({
  required P Function(Reduceable<S>) converter,
  required Widget Function({required P props}) builder,
}) =>
    StatelessWidgetWithGetItMixin(
      builder: builder,
      converter: converter,
    );

class StatelessWidgetWithGetItMixin<S, P> extends StatelessWidget
    with GetItMixin {
  final P Function(Reduceable<S>) converter;
  final Widget Function({required P props}) builder;

  StatelessWidgetWithGetItMixin({
    super.key,
    required this.converter,
    required this.builder,
  });

  @override
  Widget build(context) => builder(
        props: watchOnly(
          (ValueNotifier<S> notifier) =>
              converter(notifier.reduceable),
        ),
      );
}
