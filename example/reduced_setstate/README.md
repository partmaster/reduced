# reduced_setstate

Implementation of the 'reduced' API with StatefulWidget and InheritedWidget with following features:

1. Implementation of the ```ReducedStore``` interface 
2. Register a state for management.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```ReducedStore``` interface 

```dart
typedef ReducedStoreWidgetBuilder<S> = Widget Function(
  ReducedStore<S> store,
  Widget child,
);
```

```dart
class ReducedProviderState<S>
    extends State<ReducedProvider<S>>
    implements ReducedStore<S> {
  late S _state;

  @override
  initState() {
    super.initState();
    _state = widget.initialState;
  }

  @override
  S get state => _state;

  @override
  reduce(reducer) => setState(() => _state = reducer(_state));

  @override
  build(context) => InheritedValueWidget(
        value: ReducedStoreAndState(this),
        child: widget.child,
      );
}
```

```dart
class ReducedStoreAndState<S> {
  ReducedStoreAndState(this.store) : state = store.state;

  final ReducedStore<S> store;
  final S state;

  @override
  get hashCode => Object.hash(store, state);

  @override
  operator ==(other) =>
      other is ReducedStoreAndState &&
      state == other.state &&
      store == other.store;
}
```

#### 2. Register a state for management.

```dart
class ReducedProvider<S> extends StatefulWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    required this.child,
  });

  final S initialState;
  final Widget child;

  @override
  State<ReducedProvider> createState() =>
      ReducedProviderState<S>();
}
```

#### 3. Trigger a rebuild on widgets selectively after a state change.

```dart
class ReducedConsumer<S,P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
  required this.builder,
  required this.transformer,
  });

  final ReducedWidgetBuilder<P> builder;
  final ReducedTransformer<S, P> transformer;

  @override
  Widget build(BuildContext context) => InheritedValueWidget(
        value: transformer(
            InheritedValueWidget.of<ReducedStoreAndState<S>>(context)
                .store),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package  'reduced_setstate'.

```
dependencies:
  reduced: 
    path: ../../
  reduced_setstate: 
    path: ../reduced_setstate
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_setstate/reduced_setstate.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}

class Props {
  const Props({required this.counterText, required this.onPressed});

  final String counterText;
  final VoidCallable onPressed;
}

Props transformProps(ReducedStore<int> store) => Props(
      counterText: '${store.state}',
      onPressed: CallableAdapter(store, Incrementer()),
    );

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

Finished counter demo app using logic.dart and 'reduced_setstate' package:

```dart
// main.dart

import 'package:flutter/material.dart';
// import 'package:reduced_bloc/reduced_bloc.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

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
