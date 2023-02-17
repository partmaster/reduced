// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../widget/inherited_value_widget.dart';
import 'mobx_reducible.dart';


Widget stateProviderAdapter({
  required MyStore store,
  required Widget child,
}) =>
    InheritedValueWidget(value: store, child: child);

extension StateProviderConsumer on MyStore {
  Widget stateProviderConsumer<P>({
    required P Function(MyStore) props,
    required Widget Function({required P props}) builder,
  }) =>
      Observer(builder: (_) => builder(props: props(this)));
}
