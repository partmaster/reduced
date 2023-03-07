// setstate_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';

typedef ReducedStoreWidgetBuilder<S> = Widget Function(
  ReducedStore<S> store,
  Widget child,
);

class ReducedProvider<S> extends StatefulWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    required this.child,
  });

  final S initialState;
  final Widget child;

  @override
  State<ReducedProvider> createState() => ReducedProviderState<S>();
}

class ReducedProviderState<S> extends State<ReducedProvider<S>>
    implements ReducedStore<S> {
  late S _state;

  @override
  initState() {
    super.initState();
    _state = widget.initialState;
  }

  @override
  S get state => _state;

  @override
  reduce(reducer) => setState(() => _state = reducer(_state));

  @override
  build(context) => InheritedValueWidget(
        value: ReducedStoreAndState(this),
        child: widget.child,
      );
}

class ReducedStoreAndState<S> {
  ReducedStoreAndState(this.store) : state = store.state;

  final ReducedStore<S> store;
  final S state;

  @override
  get hashCode => Object.hash(store, state);

  @override
  operator ==(other) =>
      other is ReducedStoreAndState &&
      state == other.state &&
      store == other.store;
}
