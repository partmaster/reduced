![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced)

# reduced

Unified facade for the basic features of state management frameworks:

1. Read a current state value.
2. Update a current state value.
3. Callbacks with value semantics 

The app logic based mainly on these features should remain as independent as possible from the state management framework used. Therefore, the app logic needs a neutral state management API and an implementation of this API for the state management framework used. \
The former is provided by this package. The latter is provided by other packages listed at the end of the README.

## Features

The 'reduced' facade covers the following features of a state management framework:

### 1. Read a current state value.

```dart
abstract class Store {
    S get state;
    ...
}
```

*Samples of ```Store.get state``` use*

```get state => super.state;``` \
[*reduced_riverpod/lib/src/riverpod_store.dart#L11*](https://github.com/partmaster/reduced_riverpod/blob/80127c6364dad60207c0904bd4c8d1525280c168/lib/src/riverpod_store.dart#L11)

```get state => _state;``` \
[*reduced_getx/lib/src/getx_store.dart#L14*](https://github.com/partmaster/reduced_getx/blob/3df03742215f599f96932e92a51ff5fde56ce1dd/lib/src/getx_store.dart#L14)

### 2. Update a current state value.

```dart
abstract class Store {
    ...
  void process(Event<S> event);
}
```

Instead of writing the state value directly, the facade provides a ```process``` method that accepts a called ```event``` as a parameter. 
In the ```process``` method the ```event``` is executed with the current state value as a parameter and the return value of the ```event``` is stored as the new state value.

*Samples of ```Store.process``` use*

```process(event) => add(event);``` \
[*reduced_bloc/lib/src/bloc_store.dart#L15*](https://github.com/partmaster/reduced_bloc/blob/04049ab2061503ad4ce93a0f41266a8892696063/lib/src/bloc_store.dart#L15)

```process(event) => state = event(state);``` \
[*reduced_riverpod/lib/src/riverpod_store.dart#L14*](https://github.com/partmaster/reduced_riverpod/blob/80127c6364dad60207c0904bd4c8d1525280c168/lib/src/riverpod_store.dart#L14)

```dart
abstract class Event<S> {
    S call(S state);
}
```

All Event implementations must be derived from the ```Event``` base class.

*Samples of ```Event``` use*

```class CounterIncremented extends Event<int>``` \
[*reduced/example/counter_app/lib/logic.dart#L7*](https://github.com/partmaster/reduced/blob/d010e40e9d5498148ad00a86f003d2d672b92c70/example/counter_app/lib/logic.dart#L7)


#### 2.1 StateToPropsMapper function typedef

```dart
typedef StateToPropsMapper<S, P> = P Function(
  S state,
  EventProcessor<S> processor,
);
```

A ```StateToPropsMapper``` is a ```Function``` that uses the ```state``` and the ```procesor``` parameters to map the current state of a store into a derived 'selective' state value. Only the changes to this derived 'selective' state value determine whether a rebuild of the widget is triggered. In order for changes to be detected correctly, the derived 'selective' state value must have value semantics. \
With a ```StateToPropsMapper``` function usually a ```props``` parameter for a ```WidgetFromPropsBuilder``` function is created. 

*Samples of ```StateToPropsMapper``` use*

```final StateToPropsMapper<S, P1> propsBuilder1;``` \
[*reduced_mobx/lib/src/mobx_store.dart#L45*](https://github.com/partmaster/reduced_mobx/blob/f9fb41e999f3659c2d804146bdf28cf81d5f098f/lib/src/mobx_store.dart#L45)

```required StateToPropsMapper<S, P> propsBuilder,``` \
[*reduced_bloc/lib/src/bloc_widgets.dart#L33*](https://github.com/partmaster/reduced_bloc/blob/c2e10cd045f50a69ec4b29490cab68bcdbfb28e8/lib/src/bloc_widgets.dart#L33)


#### 2.2 WidgetFromPropsBuilder function typedef

```dart
typedef WidgetFromPropsBuilder<P> = Widget Function({
  Key? key,
  required P props,
});
```

A ```WidgetFromPropsBuilder``` is a ```Function``` that builds a new widget from the properties of the passed ```props``` parameter. That is, the ```props``` parameter must contain all the properties necessary for building the widget. 

*Samples of ```WidgetFromPropsBuilder``` use*

```final WidgetFromPropsBuilder<MyHomePageProps> builder;``` \
[*reduced/example/counter_app_with_selective_rebuild/lib/consumer.dart#L16*](https://github.com/partmaster/reduced_bloc/blob/c2e10cd045f50a69ec4b29490cab68bcdbfb28e8/example/counter_app_with_selective_rebuild/lib/consumer.dart#L16)

```required WidgetFromPropsBuilder<P> builder,``` \
[*reduced_bloc/lib/src/bloc_widgets.dart#L34*](https://github.com/partmaster/reduced_bloc/blob/c2e10cd045f50a69ec4b29490cab68bcdbfb28e8/lib/src/bloc_widgets.dart#L34)

#### 2.3 Events with additional parameters

```dart
abstract class Event1<S, V> {
  S call(S state, V value);
}
```

```dart
abstract class Event2<S, V1, V2> {
  S call(S state, V1 value1, V2 value2);
}
```

```dart
abstract class Event3<S, V1, V2, V3> ...
```

*Sample of ```Event1``` use*

```class ItemAdded extends Event1<AppState, int>``` \
[*reduced/example/shopper_app/lib/models/events.dart#L9*](https://github.com/partmaster/reduced/blob/f61fbcbf610a7b99cdc0fbee3f5b902b4df07d2f/example/shopper_app/lib/models/events.dart#L9)

#### 2.4 Adapter implementations for Events with parameters

```dart
class Parametrized1Event<S, V> extends Event<S> {
  Parametrized1Event(this.adaptee, this.value);

  final Event1<S, V> adaptee;
  final V value;

  @override call(state) => adaptee.call(state, value);

  @override get hashCode => ...
  @override operator ==(other) ...
}
```

```dart
class Parametrized2Event<S, V1, V2> extends Event<S> ...
```

```dart
class Parametrized3Event<S, V1, V2, V3> extends Event<S> ...
```

*Sample of ```Parametrized1Event``` use*

```Parametrized1Event(ItemRemoved(), value),``` \
[*reduced/example/shopper_app/lib/models/event.dart#L37*](https://github.com/partmaster/reduced/blob/f61fbcbf610a7b99cdc0fbee3f5b902b4df07d2f/example/shopper_app/lib/models/events.dart#L37)

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

```typedef VoidCallable = Callable<void>;``` \
[*reduced/lib/src/callbacks.dart#L395*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/lib/src/callbacks.dart#L395)

```final Callable<void> onPressed;``` \
[*reduced/example/counter_app/lib/logic.dart#L15*](https://github.com/partmaster/reduced/blob/ee8999c75b2acb3f223074a0207cac67e06f6e22/example/counter_app/lib/logic.dart#L15)

If the signatures of a widget callback property's function and the ```call``` method of a ```callable``` match, then the ```callable``` is assignment-compatible with the widget callback property, e.g.:

```dart
Callable1<String?, String> validator = ...
TextFormField(
    validator: validator,
    ...
);
```

#### 3.1 Action - Adapter implementations of Callable(s)

An Action carries an event to an EventProcessor and let the processor process the event.

```dart
class Action<S> extends Callable<void> {
  const Action(this.processor, this.event);

  final EventProcessor<S> processor;
  final Event<S> event;

  @override call() => processor.process(event);
  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

```dart
class Action1<S, V> extends Callable1<void, V> ...
```

```dart
class Action2<S, V1, V2> extends Callable2<void, V1, V2> ...
```

```dart
class Action3<S, V1, V2, V3> 
  extends Callable3<void, V1, V2, V3> ...
```

*Samples of ```Action``` use*

```onPressed: Action(processor, CounterIncremented()),```
[*reduced/example/counter_app/lib/logic.dart#L23*](https://github.com/partmaster/reduced/blob/734d86d7256e145f53e1459544931914aabc6915/example/counter_app/lib/logic.dart#L23)

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package of an implementation of the 'reduced' facade for a state management framework, e.g. 'reduced_bloc'.

```
dependencies:
  reduced: 0.5.0
  reduced_bloc: 
    git: 
      url: https://github.com/partmaster/reduced_bloc.git
      ref: v0.5.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import choosen implementation package for the 'reduced' facade to use the logic, e.g.

```dart
import 'package:reduced_bloc/reduced_bloc.dart';
```

## Usage (Part 1)

Implementation of the counter demo app logic with the 'reduced' facade without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart' hide Action;
import 'package:reduced/callbacks.dart';
import 'package:reduced/reduced.dart';
```

```dart
class CounterIncremented extends Event<int> {
  @override
  int call(int state) => state + 1;
}
```

```dart
class Props {
  const Props({required this.counterText, required this.onPressed});

  final String counterText;
  final VoidCallable onPressed;
}
```

```dart
class PropsMapper extends Props {
  PropsMapper(int state, EventProcessor<int> processor)
      : super(
          counterText: '$state',
          onPressed: Action(processor, CounterIncremented()),
        );
}
```

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.props});

  final Props props;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('reduced_bloc example'),
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

A neutral facade has also been developed for this features in the form of the ```registerState``` function and the ```ReducedProvider```, ```ReducedConsumer``` and ```ReducedScope``` widget classes. Since the features differ for the concrete frameworks, the signatures of the function and the widget constructors are also different, so these function and classes were not included in the 'reduced' facade, but are part of the additional API of the implementations of the 'reduced' facade.

### 1. Register a state for management.

```dart
void registerState(S initialValue);
```

```dart
class ReducedProvider<S> extends Statelesswidget {
  ReducedProvider({
    required this.initialState,
    required this.child,
  }) ...

  final S initialState, 
  final Widget child,
  ...
}
```

### 2. Trigger a rebuild on widgets selectively after a state change.

```dart
class ReducedConsumer<S, P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.mapper,
    required this.builder,
  }) ...

  final StateToPropsMapper<S, P> mapper;
  final WidgetFromPropsBuilder<P> builder;
  ...
}
```

### 3. Set up a new scope for state management.

```dart
class ReducedScope extends StatelessWidget {
  ReducedScope({
    required this.child,
  }) ...
  
  final Widget child,
  ...
}
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
  Widget build(BuildContext context) => ReducedProvider(
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) => const ReducedConsumer(
              mapper: PropsMapper.new,
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
