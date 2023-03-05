# reduced_setstate

Implementation of the 'reduced' API with StatefulWidget and InheritedWidget with following features:

1. Implementation of the ```Reducible``` interface 
2. Register a state for management.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Reducible``` interface 

```dart
typedef ReducibleWidgetBuilder<S> = Widget Function(
  Reducible<S> value,
  Widget child,
);
```

```dart
class ReducibleStatefulWidget<S> extends StatefulWidget {
  const ReducibleStatefulWidget({
    super.key,
    required this.initialState,
    required this.child,
    required this.builder,
  });

  final S initialState;
  final Widget child;
  final ReducibleWidgetBuilder<S> builder;

  @override
  State<ReducibleStatefulWidget> createState() =>
      _ReducibleStatefulWidgetState<S>();
}
```

```dart
class _ReducibleStatefulWidgetState<S>
    extends State<ReducibleStatefulWidget<S>>
    implements Reducible<S> {
  _ReducibleStatefulWidgetState(S initialState)
      : _state = initialState;

  S _state;

  @override
  S get state => _state;

  @override
  reduce(reducer) => setState(() => _state = reducer(_state));

  @override
  build(context) => widget.builder(reducible, widget.child);
}
```

#### 2. Register a state for management.

```dart
class _ReducibleAndState<S> {
  _ReducibleAndState(this.reducible) : state = reducible.state;

  final Reducible<S> reducible;
  final S state;

  @override get hashCode => ...
  @override operator ==(other) ...
}
```

```dart
Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    ReducibleStatefulWidget(
      initialState: initialState,
      child: child,
      builder: (reducible, child) => InheritedValueWidget(
        value: _ReducibleAndState(reducible),
        child: child,
      ),
    );
```

#### 4. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer<S, P extends Object>({
  required ReducedWidgetBuilder<P> builder,
  required ReducedTransformer<S, P> transformer,
}) =>
    Builder(
      builder: (context) => InheritedValueWidget(
        value: transformer(
            InheritedValueWidget.of<_ReducibleAndState<S>>(context)
                .reducible),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      ),
    );
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
  Props({required this.counterText, required this.onPressed});

  final String counterText;
  final Callable<void> onPressed;
}

Props transformProps(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: CallableAdapter(reducible, Incrementer()),
    );

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

Finished counter demo app using logic.dart and 'reduced_setstate' package:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => wrapWithProvider1(
        transformer1: transformProps,
        initialState: 0,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) => wrapWithConsumer(
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
