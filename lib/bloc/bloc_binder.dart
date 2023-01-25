import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model.dart';
import '../builder.dart';
import 'bloc.dart';

class MyAppStateProvider extends StatelessWidget {
  const MyAppStateProvider({Key? key, required this.child})
      : super(key: key);

  final MyAppState state = const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CounterBlocs(),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => BlocBuilder<CounterBlocs, MyAppState>(
        builder: (context, state) => MyHomePageBuilder(
          props: MyHomePageProps.fromState(
            context.counterBlocs.reduceableState,
          ),
        ),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => BlocBuilder<CounterBlocs, MyAppState>(
        builder: (context, state) => MyCounterWidgetBuilder(
          props: MyCounterWidgetProps.fromState(
            context.counterBlocs.reduceableState,
          ),
        ),
      );
}

extension _CounterBlocsOnContext on BuildContext {
  CounterBlocs get counterBlocs =>
      BlocProvider.of<CounterBlocs>(this);
}
