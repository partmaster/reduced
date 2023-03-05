// provider.dart

import 'package:flutter/widgets.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import 'state.dart';
import 'transformer.dart';

class MyAppStateProvider extends StatelessWidget {
  const MyAppStateProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => wrapWithProvider(
        initialState: MyAppState(title: 'reduced_setstate example'),
        child: child,
      );
}
