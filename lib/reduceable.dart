// reduceable.dart

import 'package:quiver/core.dart';

typedef Reduce<S> = void Function(Reducer<S>);

class VoidCallable<S> extends Callable<void> {
  VoidCallable(this.reduceable, this.reducer);

  final Reduceable<S> reduceable;
  final Reducer<S> reducer;

  @override
  void call() => reduceable.reduce(reducer);

  @override
  int get hashCode => hash2(reduceable, reducer);

  @override
  bool operator ==(Object other) =>
      other is VoidCallable &&
      reducer == other.reducer &&
      reduceable == other.reduceable;
}

class Reduceable<S> {
  Reduceable(this.getState, this.reduce);

  final S Function() getState;
  final Reduce<S> reduce;

  S get state => getState();

  @override
  int get hashCode => hash2(state, reduce);

  @override
  bool operator ==(Object other) =>
      other is Reduceable<S> &&
      state == other.state &&
      reduce == other.reduce;
}

abstract class Callable<T> {
  T call();
}

abstract class Reducer<S> {
  S call(S state);
}