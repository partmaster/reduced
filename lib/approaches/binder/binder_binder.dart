// binder_binder.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduceable/reduceable.dart';

import '../../domain.dart';
import '../../builder.dart';
import 'binder_reduceable.dart';

final state = StateRef(const MyAppState(
  title: 'Flutter Demo Home Page',
  counter: 0,
));
final logic = LogicRef(
  (scope) => ReduceableLogic(scope, state),
);

final homePageProps = Computed((watch) {
  watch(state);
  return null;
});

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => BinderScope(child: child);
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => createConsumer(
      stateRef: state,
      logic: context.readScope().use(logic),
      converter: MyHomePageProps.reduceable,
      builder: MyHomePageBuilder.new);
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => createConsumer(
        stateRef: state,
        logic: context.readScope().use(logic),
        converter: MyCounterWidgetProps.reduceable,
        builder: MyCounterWidgetBuilder.new,
      );
}
