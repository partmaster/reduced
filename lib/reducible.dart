// reducible.dart

/// Abstractions for a state management instance.
/// Enables decoupling of UI and logic from the state management framework used.
library reducible;

/// An abstraction for callbacks in the form of a class to easily implement value semantics.
///
/// When the constructor parameters for a widget change, it usually needs to be rebuilt.
/// If the properties in the state of a stateful widget change, 
/// the build method of the state must be re-executed.
/// Here, change usually means value semantics.
/// Many constructor parameters or state properties are callbacks in the form of methods, 
/// often implemented as function expressions.
/// Function expressions have no value semantics in Dart.
/// With classes by suitable rewriting of hashCode and operator== value semantics are easily achieved.
/// To achieve value semantics, classes rather than methods should be used for callbacks.
/// The type parameter T defines the return type of the call method.
abstract class Callable<T> {
  const Callable();

  /// Allows to use this class like a method.
  T call();
}

/// The equivalent of the [VoidCallback] as a class instead of a function.
typedef VoidCallable = Callable<void>;

/// A Reducer creates a new state of the same type from a given state.
///
/// Because the Reducer is used as a property in [Callable] implementations for callbacks, 
/// and therefore requires value semantics, Reducers are modeled as a class rather than a function.
abstract class Reducer<S> {
  const Reducer();

  /// The call method creates a new state of the same type `S` from a given state.
  ///
  /// Allows to use this class like a function.
  S call(S state);
}

/// A function that accepts a parameter of type [Reducer].
///
/// State management instances can provide this method 
/// so that the state can be changed from outside.
/// The type parameter `S` is the type of the state of the state management instance.
typedef Reduce<S> = void Function(Reducer<S>);

/// A Reducible is an abstraction for a state management instance.
///
/// The type parameter `S` is the type of the state of the state management instance.
class Reducible<S> {
  const Reducible(this.getState, this.reduce, this.identity);

  /// Reads the current state of the state management instance.
  ///
  /// The state is read again from the state management instance with each call.
  final S Function() getState;

  /// Updates the state of the state management instance.
  ///
  /// When the method is executed, the passed `reducer` is called 
  /// with the current state of the state management instance 
  /// and the return value is taken as the new state of the state management instance.
  /// The reducer must be executed synchronously.
  final Reduce<S> reduce;

  /// Controls the value semantics of this class.
  ///
  /// This class delegates its [hashCode] and [operator==] methods to the `identity` object.
  final Object identity;

  /// This class delegates the [hashCode] method to the [identity] object.
  @override
  int get hashCode => identity.hashCode;

  /// This class delegates the [operator==] method to the [identity] object.
  @override
  bool operator ==(Object other) =>
      other is Reducible<S> && identity == other.identity;
}

/// An implementation of a callback as a [reduce](Reducible.reduce) call with a [Reducer].
///
/// Or in other words, a [Reducer] bonded to a [Reducible] useable as callback.
/// The type parameter `S` is the type of the state of the [Reducible].
class BondedReducer<S> extends VoidCallable {
  const BondedReducer(this.reducible, this.reducer);

  /// The reducible to whose method [reduce](Reducible.reduce) 
  /// the [reducer] is passed when the method [call] is called.
  final Reducible<S> reducible;

  /// The reducer that is passed as a parameter to the [reduce](Reducible.reduce) method 
  /// of the [reducible] when the [call] method is called.
  final Reducer<S> reducer;

  /// Executes the [reduce](Reducible.reduce) method of the [reducible]
  ///  with the [reducer] as parameter.
  @override
  void call() => reducible.reduce(reducer);

  /// For this class to have value semantics, both constructor parameters 
  /// [reducible] and [reducer] should have value semantics.
  @override
  int get hashCode => Object.hash(reducible, reducer);

  /// For this class to have value semantics, both constructor parameters 
  /// [reducible] and [reducer] should have value semantics.
  @override
  bool operator ==(Object other) =>
      other is BondedReducer &&
      reducer == other.reducer &&
      reducible == other.reducible;
}
