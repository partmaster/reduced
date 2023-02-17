// setstate_binder.dart

import 'package:flutter/widgets.dart';

import '../../props.dart';
import '../../state.dart';
import '../../builder.dart';
import '../../util/inherited_value_widget.dart';
import 'setstate_reducible.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => ReducibleStatefulWidget(
        initialState: const MyAppState(title: 'setState'),
        child: child,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePageProps.reducible(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetProps.reducible(value),
            child: child,
          ),
        ),
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => MyHomePageBuilder(
        props: InheritedValueWidget.of<MyHomePageProps>(context),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => MyCounterWidgetBuilder(
        props: InheritedValueWidget.of<MyCounterWidgetProps>(context),
      );
}
