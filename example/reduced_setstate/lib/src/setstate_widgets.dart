// setstate_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';
import 'setstate_store.dart';

class ReducedConsumer<S,P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
  required this.builder,
  required this.transformer,
  });

  final ReducedWidgetBuilder<P> builder;
  final ReducedTransformer<S, P> transformer;

  @override
  Widget build(BuildContext context) => InheritedValueWidget(
        value: transformer(
            InheritedValueWidget.of<ReducedStoreAndState<S>>(context)
                .store),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
