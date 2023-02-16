// riverpod_reduceable.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduceable/reduceable.dart';

class ReduceableStateNotifier<S> extends StateNotifier<S> {
  ReduceableStateNotifier(super.state);

  late final reduceable = Reduceable(getState, reduce, this);

  S getState() => super.state;

  void reduce(Reducer<S> reducer) => state = reducer(state);
}

Widget binderWidget({required Widget child}) =>
    ProviderScope(child: child);

Widget builderWidget<S, P>({
  required StateProvider<P> provider,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    Consumer(
      builder: (_, ref, __) => builder(props: ref.watch(provider)),
    );
