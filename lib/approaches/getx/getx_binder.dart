// getx_binder.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../builder.dart';
import '../../domain.dart';
import 'getx_reduceable.dart';

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) {
    Get.put(ReduceableGetx(const MyAppState(title: 'getx')));
    return child;
  }
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => GetBuilder<ReduceableGetx<MyAppState>>(
        builder: (controller) => MyHomePageBuilder(
          props: MyHomePageProps.reduceable(controller.reduceable),
        ),
      );
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => GetBuilder<ReduceableGetx<MyAppState>>(
        builder: (controller) => MyCounterWidgetBuilder(
          props:
              MyCounterWidgetProps.reduceable(controller.reduceable),
        ),
      );
}
