abstract class Reducer<S> {
  S call(S state);
}

typedef Reduce<S> = void Function(Reducer<S>);

class ReduceableState<S> {
  ReduceableState(this.state, this.reduce);

  final S state;
  final Reduce<S> reduce;
}
