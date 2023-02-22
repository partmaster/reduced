// riverpod_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reduced/reduced_function_typedefs.dart';


Widget wrapWithProvider({required Widget child}) =>
    ProviderScope(child: child);

Widget wrapWithConsumer<S, P>({
  required StateProvider<P> provider,
  required PropsWidgetBuilder<P> builder,
}) =>
    Consumer(
      builder: (_, ref, __) => builder(props: ref.watch(provider)),
    );
