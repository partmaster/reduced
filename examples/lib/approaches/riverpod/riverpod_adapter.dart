// riverpod_adapter.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget stateProviderAdapter({required Widget child}) =>
    ProviderScope(child: child);

Widget stateConsumerAdapter<S, P>({
  required StateProvider<P> provider,
  required Widget Function({Key? key, required P props}) builder,
}) =>
    Consumer(
      builder: (_, ref, __) => builder(props: ref.watch(provider)),
    );
