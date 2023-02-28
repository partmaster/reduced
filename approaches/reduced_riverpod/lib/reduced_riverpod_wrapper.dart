// riverpod_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/functions.dart';

typedef ReducibleScope = ProviderScope;


Widget wrapWithScope({required Widget child}) =>
    ReducibleScope(child: child);

Widget wrapWithConsumer<S, P>({
  required StateProvider<P> provider,
  required PropsWidgetBuilder<P> builder,
}) =>
    Consumer(
      builder: (_, ref, __) => builder(props: ref.watch(provider)),
    );
