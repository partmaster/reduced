// mobx_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../typedefs.dart';
import '../../widget/inherited_value_widget.dart';
import 'mobx_reducible.dart';


Widget injectStateProvider({
  required MyStore store,
  required Widget child,
}) =>
    InheritedValueWidget(value: store, child: child);

extension InjectStateConsumer on MyStore {
  Widget injectStateConsumer<P>({
    required P Function(MyStore) props,
    required PropsWidgetBuilder<P> builder,
  }) =>
      Observer(builder: (_) => builder(props: props(this)));
}
