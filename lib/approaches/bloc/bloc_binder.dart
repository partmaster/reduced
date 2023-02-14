// bloc_binder.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain.dart';
import '../../builder.dart';
import 'bloc_reduceable.dart';

typedef MyAppStateBloc = ReduceableBloc<MyAppState>;

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => BlocProvider(
        create: (_) =>
            ReduceableBloc(const MyAppState(title: 'flutter_bloc')),
        child: child,
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      BlocSelector<MyAppStateBloc, MyAppState, MyHomePageProps>(
        selector: (state) => MyHomePageProps.reduceable(
          BlocProvider.of<MyAppStateBloc>(context).reduceable,
        ),
        builder: (context, props) => MyHomePageBuilder(
          props: props,
        ),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      BlocSelector<MyAppStateBloc, MyAppState, MyCounterWidgetProps>(
        selector: (state) => MyCounterWidgetProps.reduceable(
          BlocProvider.of<MyAppStateBloc>(context).reduceable,
        ),
        builder: (context, props) => MyCounterWidgetBuilder(
          props: props,
        ),
      );
}
