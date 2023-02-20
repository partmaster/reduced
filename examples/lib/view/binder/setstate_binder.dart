// setstate_binder.dart

import 'package:flutter/widgets.dart';
import 'package:inherited_widgets/inherited_widgets.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import '../../data/props.dart';
import '../../data/state.dart';
import '../../logic/converter.dart';
import '../builder.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => ReducibleStatefulWidget(
        initialState: const MyAppState(title: 'setState'),
        child: child,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePagePropsConverter.convert(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetPropsConverter.convert(value),
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
