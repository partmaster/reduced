The 'reduced' package defines a minimal API for the basic features of state management frameworks.

1. Read a current state value.
2. Update a current state value.
3. Transform a state value to derived 'selective' properties inclusive callback property values for 'selective' widget build.

There are dozens of state management frameworks, and each provides its own API for these basic features. 
<br/>
The app logic based mainly on these features should remain as independent as possible from the state management framework used. Therefore, the app logic needs a neutral state management API and an implementation of this API for the state management framework used.
<br/>
The former is provided by this package. The latter is provided by other packages listed at the end of the README.

## Features

The 'reduced' API covers the following features of a state management framework:

#### 1. Read a current state value.

```dart
abstract class Reducible {
    S get state;
    ...
}
```

#### 2. Update a current state value.

```dart
abstract class Reducible {
    ...
    void reduce(Reducer<S> reducer);
}
```

Instead of writing the state value directly, the API provides a ```reduce``` method that accepts a so-called ```reducer``` as a parameter. 
In the ```reduce``` method the ```reducer``` is executed with the current state value as a parameter and the return value of the ```reducer``` is stored as the new state value.

```dart
abstract class Reducer<S> {
    S call(S state);
}
```

#### 3. Transform a state value to derived 'selective' properties inclusive callback property values for 'selective' widget builds

A ```ReducedTransformer``` is a ```Function``` that uses the read and update methods of the ```reducible``` parameter to transform the current state value into a derived ```selective``` state value. Only the changes to this derived 'selective' state value determine whether a rebuild of the widget is triggered. In order for changes to be detected correctly, the derived 'selective' state value must have value semantics.

```dart
typedef ReducedTransformer<S, P> = P Function(Reducible<S> reducible);
```

The ```Callable``` classes serve as base classes for callback property values ​​in the derived 'selective' state values ​​generated by ```ReducedTransformer``` functions.
Many widgets have callback properties of type ```Function```. The ```Function``` type has no value semantics (each function is unique), this also applies to anonymous functions, which are often used as values ​​for widget callback properties.
To grant value semantics, ```Callable``` can be used in the derived 'selective' state values ​​instead of anonymous functions.

```dart
abstract class Callable<T> {
    T call();
}
```

```dart
abstract class Callable1<T, V> {
    T call(V value);
}
```

```dart
abstract class Callable2<T, V1, V2> {
    T call(V1 value1, V2 value2);
}
```

```dart
abstract class Callable3<T, V1, V2, V3> {
    T call(V1 value1, V2 value2, V3 value3);
}
```

If the signatures of a widget callback property's function and the ```call``` method of a ```callable``` match, then the ```callable``` is assignment-compatible with the widget callback property, e.g.:

```dart
Callable1<String?, String> validator = ...
TextFormField(
    validator: validator,
    ...
);

```

A ```ReducedWidgetBuilder``` is a ```Function``` that builds a new widget from the properties of the passed ```props``` parameter. That is, the ```props``` parameter must contain all the properties necessary for building the widget.

```dart
typedef ReducedWidgetBuilder<P> = Widget Function({required P props});
```

#### 4. Adapter implementations of Callable(s)

```dart
class ReducerOnReducible<S> extends Callable<void> {
  const ReducerOnReducible(this.reducible, this.reducer);

  final Reducible<S> reducible;
  final Reducer<S> reducer;

  @override call() => reducible.reduce(reducer);

  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

```dart
class Reducer1OnReducible<S, V> extends Callable1<void, V> ...
```

```dart
class Reducer2OnReducible<S, V1, V2> extends Callable2<void, V1, V2> ...
```

```dart
class Reducer3OnReducible<S, V1, V2, V3> extends Callable3<void, V1, V2, V3> ...
```

#### 5. Adapter implementations of Reducer(s)

```dart
class Reducer1Adapter<S, V> extends Reducer<S> {
  Reducer1Adapter(this.adaptee, this.value);

  final Reducer1<S, V> adaptee;
  final V value;

  @override call(state) => adaptee.call(state, value);

  @override get hashCode => ...
  @override operator ==(other) ...
}
```

```dart
class Reducer2Adapter<S, V1, V2> extends Reducer<S> ...
```

```dart
class Reducer3Adapter<S, V1, V2, V3> extends Reducer<S> ...
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package of an implementation of the 'reduced' API for a state management framework, e.g. 'reduced_bloc'.

## Usage (Part 1)

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counterText, required this.onPressed});
  final String counterText;
  final Callable<void> onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: ReducerOnReducible(reducible, Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: Text('reduced_bloc example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text('${props.counterText}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
```

## Extended Features

In addition to the basic features, state management frameworks also offer these advanced features:

1. Register a state for management.
2. Trigger a rebuild on widgets selectively after a state change.
3. Set up a new scope for state management.

A neutral API has also been developed for this features in the form of the ```registerState```, ```wrapWithProvider```, ```wrapWithConsumer``` and ```wrapWithScope``` functions. Since the features differ for the concrete frameworks, the signature of the functions is also different, so these functions were not included in the 'reduced' API, but are part of the additional API of the implementations of the 'reduced' API.

#### 1. Register a state for management.

```dart
void registerState(S initialValue);
```

```dart
Widget wrapWithProvider<S>({required S initialState, required Widget child}});
```

#### 2. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer({
    required ReducedTransformer<S, P> transformer,
    required ReducedWidgetBuilder<P> builder,
});
```

#### 3. Set up a new scope for state management.

```dart
Widget wrapWithScope({required Widget child});
```

# Usage (Part 2)

Finished counter demo app using logic.dart and 'reduced_bloc' package, an implementation of the 'reduced' API on the 'Bloc' state management framework:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_bloc/reduced_bloc.dart';
import 'logic.dart';

void main() => runApp(
      wrapWithProvider(
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) =>
                context.bloc<int>().wrapWithConsumer(
                      transformer: transformer,
                      builder: builder,
                    ),
          ),
        ),
      ),
    );
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|Framework|'reduced'-Implementierung|
|---|---|
|[Bloc]()|[reduced_bloc]()|

