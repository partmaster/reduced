// redux_binder.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../builder.dart';
import '../../domain.dart';
import '../../reduceable.dart' as reduceable;
import 'redux_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  static final Store<MyAppState> store =
      Store(reducer, initialState: const MyAppState(title: 'redux'));

  static MyAppState reducer(MyAppState state, dynamic action) =>
      action is reduceable.Reducer ? action(state) : state;

  @override
  Widget build(context) => StoreProvider(store: store, child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => builderWidget(
        builder: MyHomePageBuilder.new,
        converter: MyHomePageProps.reduceable,
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => builderWidget(
        builder: MyCounterWidgetBuilder.new,
        converter: MyCounterWidgetProps.reduceable,
      );
}
