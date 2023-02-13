// reduceable.dart

abstract class Callable<T> {
  T call();
}

typedef VoidCallable = Callable<void>;

abstract class Reducer<S> {
  S call(S state);
}
typedef Reduce<S> = void Function(Reducer<S>);

class Reduceable<S> {
  Reduceable(this.getState, this.reduce, this.equality);

  final S Function() getState;
  final Reduce<S> reduce;
  final Object equality;

  S get state => getState();

  @override
  int get hashCode => equality.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Reduceable<S> && equality == other.equality;
}

class Action<S> extends VoidCallable {
  Action(this.reduceable, this.reducer);

  final Reduceable<S> reduceable;
  final Reducer<S> reducer;

  @override
  void call() => reduceable.reduce(reducer);

  @override
  int get hashCode => Object.hash(reduceable, reducer);

  @override
  bool operator ==(Object other) =>
      other is Action &&
      reducer == other.reducer &&
      reduceable == other.reduceable;
}
