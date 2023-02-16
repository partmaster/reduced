// reducible.dart

library reducible;

/// An abstraction for callbacks in the form of a class to easily implement value semantics.
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change, the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods, often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
/// The type parameter T defines the return type of the call method.
abstract class Callable<T> {
  /// Allows to use this class like a method.
  T call();
}

/// The equivalent of the VoidCallback as a class instead of a method.
typedef VoidCallable = Callable<void>;

/// A reducer creates a new state of the same type from a given state.
///
/// For the same reasons as for the callable, the reducer is modeled as a class and not as a method.
abstract class Reducer<S> {
  /// The call method creates a new state of the same type S from a given state.
  ///
  /// Allows to use this class like a method.
  S call(S state);
}

/// A method that accepts a parameter of type Reducer.
///
/// State management instances can provide this method so that the state can be changed from outside.
typedef Reduce<S> = void Function(Reducer<S>);

/// A Reducible is an abstraction for a State Management instance.
///
/// The type parameter S is the type of the state of the state management instance.
class Reducible<S> {
  const Reducible(
    this.getState,
    this.reduce,
    this.identity,
  );

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  final S Function() getState;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed reducer is called with the current state of the state management instance and the return value is taken as the new state of the state management instance.
  /// The reducer must be synchronous.
  final Reduce<S> reduce;

  /// Controls the value semantics of the Reducible.
  ///
  /// The Reducible delegates its hashCode and operator== methods to the identity object.  */
  final Object identity;

  /// The reducible delegates the hashCode method to the identity constructor parameter.
  @override
  int get hashCode => identity.hashCode;

  /// The reducible delegates the operator== method to the identity constructor parameter.
  @override
  bool operator ==(Object other) =>
      other is Reducible<S> && identity == other.identity;
}

/// An implementation of a callback as a reducer of a reducible.
///
/// The type parameter S is the type of the state of the reducible.
class Action<S> extends VoidCallable {
  Action(this.reducible, this.reducer);

  /// The Reducible to whose method reduce the reducer is passed when the method call is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the reduce method of the reducible when the call method is called.
  final Reducer<S> reducer;

  /// Executes the reduce method of the reducible with the reduce parameter.
  @override
  void call() => reducible.reduce(reducer);

  /// For the action to have value semantics, both constructor parameters reducible and reducer should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For the action to have value semantics, both constructor parameters reducible and reducer should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is Action &&
      reducer == other.reducer &&
      reducible == other.reducible;
}
