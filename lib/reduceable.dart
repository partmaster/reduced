// reduceable.dart

abstract class Reducer<S> {
  S call(S state);
}

typedef Reduce<S> = void Function(Reducer<S>);

class Reduceable<S> {
  Reduceable(this.state, this.reduce);

  final S state;
  final Reduce<S> reduce;
}
