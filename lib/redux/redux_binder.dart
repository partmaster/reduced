// redux_binder.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../builder.dart';
import '../domain.dart';
import '../reduceable.dart' as reduceable;
import 'redux_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final Store<MyAppState> store = Store(
    reducer,
    initialState: const MyAppState(
      title: 'Flutter Demo Home Page',
      counter: 0,
    ),
  );

  static MyAppState reducer(MyAppState state, dynamic action) =>
      action is reduceable.Reducer ? action(state) : state;

  @override
  Widget build(context) => StoreProvider(store: store, child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      StoreConnector<MyAppState, MyHomePageProps>(
        converter: (store) => MyHomePageProps.reduceable(
          store.reduceable<MyAppState>(),
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
      StoreConnector<MyAppState, MyCounterWidgetProps>(
        converter: (store) => MyCounterWidgetProps.reduceable(
          store.reduceable(),
        ),
        builder: (context, props) => MyCounterWidgetBuilder(
          props: props,
        ),
      );
}
