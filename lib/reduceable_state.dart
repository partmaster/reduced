
typedef Reducer<S, V> = S Function(S, V);
typedef Reduce<S> = void Function<V>(Reducer<S, V>, V);

class ReduceableState<S> {
  ReduceableState(this.state, this.reduce);

  final S state;
  final Reduce<S> reduce;
}

