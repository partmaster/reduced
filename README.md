![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced)

# reduced

Minimal API for the basic features of state management frameworks:

1. Read a current state value.
2. Update a current state value.
3. Callbacks with value semantics 

The app logic based mainly on these features should remain as independent as possible from the state management framework used. Therefore, the app logic needs a neutral state management API and an implementation of this API for the state management framework used.
<br/>
The former is provided by this package. The latter is provided by other packages listed at the end of the README.

## Features

The 'reduced' API covers the following features of a state management framework:

### 1. Read a current state value.

```dart
abstract class Reducible {
    S get state;
    ...
}
```

*Samples of ```Reducible.get state``` use*

```get state => super.state;```
<br/>
[*reduced_riverpod/lib/src/riverpod_reducible.dart#L12*](https://github.com/partmaster/reduced_riverpod/blob/cd2ffa2d70ac459440bfd888cd9f3c17423cb462/lib/src/riverpod_reducible.dart#L12)

```get state => _state;```
<br/>
[*reduced_getx/lib/src/getx_reducible.dart#L13*](https://github.com/partmaster/reduced_getx/blob/d9133163aba67a700a1d86bdce9a2248693891d0/lib/src/getx_reducible.dart#L13)

### 2. Update a current state value.

```dart
abstract class Reducible {
    ...
    void reduce(Reducer<S> reducer);
}
```

Instead of writing the state value directly, the API provides a ```reduce``` method that accepts a so-called ```reducer``` as a parameter. 
In the ```reduce``` method the ```reducer``` is executed with the current state value as a parameter and the return value of the ```reducer``` is stored as the new state value.

*Samples of ```Reducible.reduce``` use*

```reduce(reducer) => add(reducer);```
<br/>
[*reduced_bloc/lib/src/bloc_reducible.dart#L15*](https://github.com/partmaster/reduced_bloc/blob/1a26bb2e06fb67866fbb325e12bc8c912bcc4a18/lib/src/bloc_reducible.dart#L15)

```reduce(reducer) => state = reducer(state);```
<br/>
[*reduced_riverpod/lib/src/riverpod_reducible.dart#L15*](https://github.com/partmaster/reduced_riverpod/blob/cd2ffa2d70ac459440bfd888cd9f3c17423cb462/lib/src/riverpod_reducible.dart#L15)

```dart
abstract class Reducer<S> {
    S call(S state);
}
```

All Reducer implementations must be derived from the ```Reducer``` base class.

*Samples of ```Reducer``` use*

```class Incrementer extends Reducer<int>```
<br/>
[*reduced/example/counter_app/lib/logic.dart#L6*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/counter_app/lib/logic.dart#L6)


#### 2.1 ReducedTransformer function typedef

```dart
typedef ReducedTransformer<S, P> = P Function(
  Reducible<S> reducible,
);
```

A ```ReducedTransformer``` is a ```Function``` that uses the read and update methods of the ```reducible``` parameter to transform the current state value into a derived 'selective' state value. Only the changes to this derived 'selective' state value determine whether a rebuild of the widget is triggered. In order for changes to be detected correctly, the derived 'selective' state value must have value semantics. 
<br/>
With a ```ReducedTransformer``` function usually a ```props``` parameter for a ```ReducedWidgetBuilder``` function is created. 

*Samples of ```ReducedTransformer``` use*

```final ReducedTransformer<S, P1> transformer1;```
<br/>
[*reduced_mobx/lib/src/mobx_reducible.dart#L25*](https://github.com/partmaster/reduced_mobx/blob/8e4664a3aa20ea8b9f2eb32005e6c58ae74f7615/lib/src/mobx_reducible.dart#L25)

```required ReducedTransformer<S, P> transformer,```
<br/>
[*reduced_bloc/lib/src/bloc_wrapper.dart#L21*](https://github.com/partmaster/reduced_bloc/blob/1a26bb2e06fb67866fbb325e12bc8c912bcc4a18/lib/src/bloc_wrapper.dart#L21)


#### 2.2 ReducedWidgetBuilder function typedef

```dart
typedef ReducedWidgetBuilder<P> = Widget Function({
  required P props,
});
```

A ```ReducedWidgetBuilder``` is a ```Function``` that builds a new widget from the properties of the passed ```props``` parameter. That is, the ```props``` parameter must contain all the properties necessary for building the widget. 

*Samples of ```ReducedWidgetBuilder``` use*

```final ReducedWidgetBuilder<MyHomePageProps> builder;```
<br/>
[*reduced/example/counter_app_with_selective_rebuild/lib/consumer.dart#L16*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/counter_app_with_selective_rebuild/lib/consumer.dart#L16)

```required ReducedWidgetBuilder<P> builder,```
<br/>
[*reduced_bloc/lib/src/bloc_wrapper.dart#L22*](https://github.com/partmaster/reduced_bloc/blob/1a26bb2e06fb67866fbb325e12bc8c912bcc4a18/lib/src/bloc_wrapper.dart#L22)

#### 2.3 Reducers with additional parameters

```dart
abstract class Reducer1<S, V> {
  S call(S state, V value);
}
```

```dart
abstract class Reducer2<S, V1, V2> {
  S call(S state, V1 value1, V2 value2);
}
```

```dart
abstract class Reducer3<S, V1, V2, V3> ...
```

*Sample of ```Reducer1``` use*

```class AddItemReducer extends Reducer1<AppState, int>```
<br/>
[*reducedexample/shopper_app/lib/models/reducer.dart#L9*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/shopper_app/lib/models/reducer.dart#L9)

#### 2.4 Adapter implementations for Reducers with parameters

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

*Sample of ```Reducer1Adapter``` use*

```Reducer1Adapter(RemoveItemReducer(), value),```
<br/>
[*reduced/example/shopper_app/lib/models/reducer.dart#L37*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/shopper_app/lib/models/reducer.dart#L37)

### 3. Callbacks with value semantics 

Many widgets have callback properties of type ```Function```. The ```Function``` type has no value semantics (each function is unique), this also applies to anonymous functions, which are often used as values ​​for widget callback properties.
If value semantics are needed, ```Callable``` can be used for callback properties in the derived 'selective' state values instead of anonymous functions.

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

*Samples of ```Callable``` use*

```typedef VoidCallable = Callable<void>;```
<br/>
[*reduced/lib/src/callbacks.dart#L395*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/lib/src/callbacks.dart#L395)

```final Callable<void> onPressed;```
<br/>
[*reduced/example/counter_app/lib/logic.dart#L15*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/counter_app/lib/logic.dart#L15)

If the signatures of a widget callback property's function and the ```call``` method of a ```callable``` match, then the ```callable``` is assignment-compatible with the widget callback property, e.g.:

```dart
Callable1<String?, String> validator = ...
TextFormField(
    validator: validator,
    ...
);
```

#### 3.1 Adapter implementations of Callable(s)

```dart
class CallableAdapter<S> extends Callable<void> {
  const CallableAdapter(this.reducible, this.reducer);

  final Reducible<S> reducible;
  final Reducer<S> reducer;

  @override call() => reducible.reduce(reducer);

  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

```dart
class Callable1Adapter<S, V> extends Callable1<void, V> ...
```

```dart
class Callable2Adapter<S, V1, V2> extends Callable2<void, V1, V2> ...
```

```dart
class Callable3Adapter<S, V1, V2, V3> 
  extends Callable3<void, V1, V2, V3> ...
```

*Samples of ```CallableAdapter``` use*

```onPressed: CallableAdapter(reducible, Incrementer()),```
[*reduced/example/counter_app/lib/logic.dart#L20*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/counter_app/lib/logic.dart#L20)

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package of an implementation of the 'reduced' API for a state management framework, e.g. 'reduced_bloc'.

```
dependencies:
  reduced:
    git: 
      url: https://github.com/partmaster/reduced.git
      ref: main
  reduced_bloc: 
    git: 
      url: https://github.com/partmaster/reduced_bloc.git
      ref: main
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import choosen implementation package for the 'reduced' API to use the logic, e.g.

```dart
import 'package:reduced_bloc/reduced_bloc.dart';
```

## Usage (Part 1)

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';
```

```dart
class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}
```

```dart
class Props {
  Props({required this.counterText, required this.onPressed});

  final String counterText;
  final Callable<void> onPressed;
}
```

```dart
Props transformProps(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: CallableAdapter(reducible, Incrementer()),
    );
```

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.props});

  final Props props;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('reduced_fluttercommand example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(props.counterText),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: props.onPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```

## Extended Features

In addition to the basic features, state management frameworks also offer these advanced features:

1. Register a state for management.
2. Trigger a rebuild on widgets selectively after a state change.
3. Set up a new scope for state management.

A neutral API has also been developed for this features in the form of the ```registerState```, ```wrapWithProvider```, ```wrapWithConsumer``` and ```wrapWithScope``` functions. Since the features differ for the concrete frameworks, the signature of the functions is also different, so these functions were not included in the 'reduced' API, but are part of the additional API of the implementations of the 'reduced' API.

### 1. Register a state for management.

```dart
void registerState(S initialValue);
```

```dart
Widget wrapWithProvider<S>({
  required S initialState, 
  required Widget child,
});
```

### 2. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer<S, P>({
    required ReducedTransformer<S, P> transformer,
    required ReducedWidgetBuilder<P> builder,
});
```

### 3. Set up a new scope for state management.

```dart
Widget wrapWithScope({required Widget child});
```

# Usage (Part 2)

Finished counter demo app using logic.dart and 'reduced_bloc' package, an implementation of the 'reduced' API on [Bloc](https://bloclibrary.dev/#/):

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_bloc/reduced_bloc.dart';

import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => wrapWithProvider(
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) =>
                context.bloc<int>().wrapWithConsumer(
                      transformer: transformProps,
                      builder: MyHomePage.new,
                    ),
          ),
        ),
      );
}
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Binder](https://pub.dev/packages/binder)|[reduced_binder](https://github.com/partmaster/reduced_binder)|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[FlutterCommand](https://pub.dev/packages/flutter_command)|[reduced_fluttercommand](https://github.com/partmaster/reduced_fluttercommand)|
|[FlutterTriple](https://pub.dev/packages/flutter_triple)|[reduced_fluttertriple](https://github.com/partmaster/reduced_fluttertriple)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[MobX](https://pub.dev/packages/mobx)|[reduced_mobx](https://github.com/partmaster/reduced_mobx)|
|[Provider](https://pub.dev/packages/provider)|[reduced_provider](https://github.com/partmaster/reduced_provider)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
|[Solidart](https://pub.dev/packages/solidart)|[reduced_solidart](https://github.com/partmaster/reduced_solidart)|
|[StatesRebuilder](https://pub.dev/packages/states_rebuilder)|[reduced_statesrebuilder](https://github.com/partmaster/reduced_statesrebuilder)|
