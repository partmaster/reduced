# Design patterns for state management in Flutter

## Author

Steffen Nowacki · PartMaster GmbH · [www.partmaster.de](https://www.partmaster.de)

## Abstract

This article presents the adoption of two design patterns that decouple the UI and logic of a Flutter app from the state management framework used and make the code more concise.
<br/><br/> 
State management frameworks are used to separate UI from logic. They often have the side effect of infiltrating UI and logic, creating unwanted dependencies. This can be counteracted with a combination of the "State Reducer" and "Humble Object" design patterns and the concept of functional programming with immutable state objects. The building blocks used in the implementation of the design patterns ``Reducer``, ``Reducible`` and ``Callable`` as well as ``Binder``, ``Builder``, ``Props`` and ``Transformer`` are explained in this article. The resulting code structure is easier to read, maintain, and test, and is compatible with popular state management frameworks, such as Riverpod or Bloc. 
<br/> 
These advantages come at a cost: Compared to the direct use of a state management framework or the use of mutable state objects, there is an additional abstraction layer and more boilerplate code.
<br/><br/> 
If you want to stay flexible when using state management frameworks, or if you want to make your widget tree code structure clearer, or if you just want to get an overview of available state management frameworks, this article might be interesting for you. 

<div style="page-break-after: always;"></div>
# Part 1<br/>Responsibilities<br/>in the counter demo app.

Flutter [^1] describes itself with the phrase "Almost everything is a widget" [^2]. What is meant by this is that most features are implemented in the form of widget classes that can be plugged together like Lego bricks. This is a great feature. But there is also a small downside: if you are not careful, responsibilities easily get mixed up in the resulting widget trees. 

Let's take the well-known Counter demo app as an example:

```dart
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

The ``_MyHomePageState`` class holds various responsibilities: 

### 1\. Layout

```dart
          mainAxisAlignment: MainAxisAlignment.center,
```

### 2\. Rendering 

```dart
              style: Theme.of(context).textTheme.headline4,
```

### 3\. Gesture detection

```dart
        onPressed:
```

### 4\. App state storage

```dart
  int _counter = 0;
```

### 5\. App state change operations

```dart
  void _incrementCounter() {
```

### 6\. Widget rebuilds after app state changes

```dart
    setState(() {
```

### 7\. Conversion of app state to display properties

```dart
              '$_counter',
```

### 8\. Mapping gesture callbacks to app state change operations.

```dart
        onPressed: _incrementCounter,
```
## Conclusion on responsibilities of the counter demo app

The ``_MyHomePageState`` class of the Counter demo app is an example of a class with many responsibilities. For a demonstration of basic Flutter features, it is understandable to omit separation of concerns in favor of compact presentation. 
As an example for clean code [^3] the counter demo app is rather unsuitable in my opinion. 
<br/><br/> 
The principle of separation of concerns [^4] has long been known. Nevertheless, its enforcement, especially within UI code, is always a challenge in my experience. UI code has the peculiarity that it is tightly bound to its runtime environment, the UI framework, and therefore basically already has an initial complexity. Since this complexity of UI code is inherent and unavoidable, the only goal is to increase it as little as possible. And solutions that cause some boilerplate code [^5] can also be helpful here.

<div style="page-break-after: always;"></div>
# Part 2<br/>Applying the Humble Object Pattern

A design pattern that fits this problem exactly is the Humble Object pattern [^6] by Micheal Feathers.

## The definition of the Humble Object pattern

The summary of the Humble Object pattern is: 

> If code is not well testable because it is too tightly coupled with its environment, extract the logic into a separate, easily testable component that is decoupled from its environment.

The following two diagrams in Figs. 1 and 2 illustrate the situation before and after applying this design pattern:  

![humble1](images/humble1.png)
<br/>
*Fig. 1: Situation before applying the Humble Object pattern (image source: manning.com [^7])*.

![humble2](images/humble2.png)
<br/>
*Fig. 2: Situation after applying the Humble Object pattern (image source: manning.com [^8])*.

## Counter demo app refactored

For a small demo app like the Counter demo app, it's fitting that so many responsibilities are grouped into a single class.
<br/>
Nevertheless, I chose this app to apply the Humble Object pattern to and use the result to evaluate the usefulness of the pattern for Flutter widget trees.
<br/><br/>
Here is the result of applying the pattern in the form of the new classes in which the various responsibilities (or pieces of logic) have been extracted from the original class ```_MyHomePageState``` and the remaining Humble Object class ``` MyHomePageBuilder```.
<br/><br/>
|Note|
|---|
| In the extracted classes I have used an abstraction for the state management system, consisting of the interfaces ```Reducible```, ```Reducer``` and ```Callable```, the class ```ReducerOnReducible ``` and the ```wrapWithProvider``` and ```wrapWithConsumer``` functions, which I'll discuss later. |

### App state storage

I have modeled two constructs for storing the app state:
A class ```MyAppState``` for the actual app state.
A class ```MyAppStateBinder``` that sets the initial value of the app state and passes it to the ```wrapWithProvider``` function.

The ```wrapWithProvider``` function abstracts the state management framework used and makes it accessible for subsequent widgets in the widget tree.

#### MyAppState

To be able to save the app state, I moved the property ```counter``` to a class ```MyAppState``` and added the property ```title```, although the property is never changed.

```dart 
class MyAppState {
  const MyAppState({required this.title, this.counter = 0});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );

  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

#### MyAppStateBinder

The ```MyAppStateBinder``` class binds the specific app state class ```MyAppState``` to a state management instance using the ```wrapWithProvider``` function.

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => wrapWithProvider(
        initialState: const MyAppState(title: 'flutter_bloc'),
        child: child,
      );
}
```

### App State Change Operations

The Counter demo app has only one app state change operation.

#### IncrementCounterReducer

The ```call``` method of the ```IncrementCounterReducer``` class creates a new ```MyAppState``` value in which the property ```counter``` is compared to the ```MyAppState``` value passed as parameter ```state``` has been incremented.

The base class ```Reducer``` defines the signature of the ```call``` method for all app state change operations: ```MyAppState call(MyAppState state);``` and is explained later.

```dart
class IncrementCounterReducer extends Reducer<MyAppState> {
  const IncrementCounterReducer._();

  static const instance = IncrementCounterReducer._();

  @override
  call(state) => state.copyWith(counter: state.counter + 1);
}
```

### Widget rebuilds after app state changes

I have provided the function ```wrapWithConsumer``` for notification of a necessary rebuild after app state changes.

The ```wrapWithConsumer``` function abstracts the state management framework used and ensures that the passed ```builder``` is called whenever the app state changes.
The passed ```transformer``` transforms the actual ```MyAppState``` into the parameter type expected by the ```builder```.

#### MyHomePageStateBinder

The class ```MyHomePageStateBinder``` specifies that the widget ```MyHomePageBuilder``` is built and that the function ```MyHomePagePropsTransformer.transform``` is used to set the required constructor parameter for fir class ```MyHomePageBuilder```.

```dart
class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      context.bloc<MyAppState>().wrapWithConsumer(
            builder: MyHomePageBuilder.new,
            transformer: MyHomePagePropsTransformer.transform,
          );
}
```

### Conversion of app state to display properties

When creating the widget tree, some widget constructor properties depend on the current app state. These are combined into their own property classes. In addition, a ```transform``` function is defined for each property class, which can transform the app state into an instance of the property class.

#### MyHomePageStateProps 

The properties needed in the build method of ```MyHomePageBuilder``` are grouped in the class ```MyHomePageProps```.

```dart
class MyHomePageProps {
  const MyHomePageProps({
    required this.title,
    required this.counterText,
    required this.onIncrementPressed,
  });

  final String title;
  final String counterText;
  final Callable<void> onIncrementPressed;

  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

#### MyHomePageStatePropsTransformer

```dart
class MyHomePagePropsTransformer {
  static MyHomePageProps transform(Reducible<MyAppState> reducible) =>
      MyHomePageProps(
        title: reducible.state.title,
        counterText: '${reducible.state.counter}',
        onIncrementPressed: reducible.incrementCounterReducer,
      );
}
```

### Mapping of gesture callbacks to app state change operations

Flutter widgets provide callback properties for gesture processing and similar purposes.
We'll treat callback properties the same as the display properties discussed earlier and add them to the same properties class ```MyHomePageProps```. The ```transform``` function generates the value for the ```onIncrementPressed``` callback property from the app state operation ```IncrementCounterReducer```.

To do this, a convenience method ```get incrementCounterReducer``` is defined,
which binds the app state operation to the state management instance using the ```ReducerOnReducible``` class.

#### get incrementCounterReducer

```dart
extension IncrementCounterReducerOnReducible
    on Reducible<MyAppState> {
  ReducerOnReducible get incrementCounterReducer =>
      ReducerOnReducible(this, IncrementCounterReducer.instance);
}
```

### Layout, rendering and gesture detection

I couldn't separate out the remaining responsibilities of layout, rendering and gesture recognition because they can hardly be separated from the UI framework. They remain in the resulting Humble object in the ```MyHomePageStateBuilder``` class.

#### MyHomePageStateBuilder

In the converted Counter demo app, the ```MyHomePageBuilder``` class makes up the Humble object and is responsible for layout, rendering and gesture detection.

```dart
class MyHomePageBuilder extends StatelessWidget {
  const MyHomePageBuilder({super.key, required this.props});

  final MyHomePageProps props;

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: Text(props.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                props.counterText,
                style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: props.onIncrementPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```

## Conclusion on using the Humble Object pattern

Applying the Humble Object pattern to a Flutter widget class that produces a widget tree and has app state dependencies consists of the following five steps:

1. If the widget class has both UI tasks and
solves app state tasks, then this widget class is split into a Builder class, a Binder class, a Props class, and a transform function to create props instances.

2. The Builder class is a ```StatelessWidget```. It gets the props instance with ready-made properties and callbacks from the binder class in the constructor and creates a widget tree from layout, renderer and gesture detection widgets in the ```build``` method.

3. At the state management instance, the Binder class selectively listens for changes to 'its' Props and returns a Builder class widget in the build method.

4. A Props class is defined for the ready-made properties and callbacks of the Builder class - a pure data class with only final fields.

5. A transform function is defined for the Props class, which generates the values ​​for the properties from the current app state and the values ​​for the callbacks from the Reducer implementations.

The diagram in Fig. 3 shows the interaction of the components when implementing the Humble Object Pattern with Binder, Builder, Props and Transformer.

![humble_widget](images/humble_widget.png)
*Fig. 3: Implementation of the Humble Object Pattern with Binder, Builder, Props and Transformer*

These steps applied to the Counter demo app bring the following result:

Three responsibilities from the ```_MyHomePageState``` class remain in the Humble Object:

1. Layout
2. Rendering
3. Mapping of gesture callbacks to app state change operations

FFive responsibilities were extracted from the ```_MyHomePageState``` class into their own classes or functions:
  
1. App state storage
2. Providing operations for app state changes
3. Widget notification after app state changes
4. Conversion of app state to display properties
5. Mapping of gesture callbacks to app state change operations

The source code of the refactored counter demo app can be found here: [github.com/partmaster/reduced/tree/main/examples/counter_app](https://github.com/partmaster/reduced/tree/main/examples/counter_app).
<br/><br/> 
In addition to the counter demo app, I also refactored the example project [Simple app state management](https://docs.flutter.dev/development/data-and-backend/state -mgmt/simple) from the official Flutter state management documentation. The result can be found here:[github.com/partmaster/reduced/tree/main/examples/shopper_app](https://github.com/partmaster/reduced/tree/main/examples/shopper_app).
<br/><br/>
In the classes and functions extracted after the Humble Object Pattern, a lot of boilerplate code was created and a state management abstraction was used. The abstraction consists of the interfaces ```Reducible```, ```Reducer``` and ```Callable```, the class ```ReducerOnReducible``` and the functions ```wrapWithProvider``` and ```wrapWithConsumer```. 
<br/><br/>
I hope this has piqued your interest, as I now want to present the abstraction used for the state management system.

<div style="page-break-after: always;"></div>
# Part 3<br/>Application of the State Reducer Pattern

All five responsibilities extracted using the Humble Object Pattern are state management responsibilities.
<br/><br/> 
In the Counter demo app, state management is implemented with a StatefulWidget. The StatefulWidget and the InheritedWidget are the two state management building blocks provided by Flutter. These two building blocks are low-level building blocks. Non-trivial apps usually require a higher quality state management solution. Many frameworks have emerged in the Flutter community to fill this need. The official Flutter documentation currently lists 13 such state management frameworks [^9].
<br/><br/>
After having painstakingly (and with boilerplate code) removed five responsibilities from their dependency on the UI environment, it is only logical to use a suitable abstraction to protect them from being dependent on a specific state management framework.
<br/><br/>
I call the abstraction 'reduced' in reference to the underlying pattern. The essential components of the 'reduced' abstraction have already been listed:

1. Interface **Reducer**<br/>
Definition of operations to change the app state.

2. Interface **Reducible**<br/>
Reading and updating app state in a state management instance.

3. Interface **Callable**<br/>
Basis for defining classes with value semantics [^10] whose instances can be assigned to callback properties of Flutter widgets,
<br/> 
for use in the Props classes mentioned in the chapter on using the Humble Object pattern , so these classes can also be defined with value semantics.

4. Klasse **ReducerOnReducible**<br/>
Association of an app state operation with the state management instance on which it is to be executed.

5. Funktion **wrapWithProvider**<br/>
The ```wrapWithProvider``` function makes state management functionality accessible for subsequent widgets in the widget tree. 

6. Funktion **wrapWithConsumer**<br/>
The ```wrapWithConsumer``` function ensures that the rebuild of a widget is appropriately triggered by the state management framework.

## The definition of the State Reducer pattern

The overview is followed by the detailed description of the 'reduced' abstraction for state management frameworks. At its core, the abstraction is an application of the State Reducer pattern, so this design pattern is presented first.

Put simply, the State Reducer Pattern requires that any change to the app state be performed as an atomic operation with the current app state as a parameter and a new app state as the result. Actions that potentially run longer (database queries, network calls, ..) usually have to be implemented with several atomic app state changes because of this requirement, e.g. one at the beginning of the action and one at the end. It is crucial that the app state change at the end of the action does not (re)use the app state result from the beginning of the action as a parameter, but the then current app state of the state management framework. The pattern supports this intention by ensuring that you do not have to fetch the current app status yourself when there is a change, but that it is delivered without being asked.
<br/><br/>
Or to put it more analytically: The state reducer pattern models the app state as the result of a Fold function [^11] from the initial app state and the sequence of previous app state change actions.
<br><br/>
Dan Abramov and Andrew Clark used this concept in the Javascript framework Redux [^12] and popularized the name *Reducer* [^13] for the combination operator that calculates a new app state from the current app state and an action:

> Reducers are functions that take the current state and an action as arguments and return a new state result.
<br/>
In other words: ```(state, action) => newState```.

![reducer](images/reducer_killalldefectscom.png)
<br/>
*Fig. 4: Principle of the State Reducer Pattern (Image source: killalldefects.com [^14])*

In terms of app code, this means:

1. An AppState class is defined for the app state - a pure data class with only final fields and a const constructor. The state management API provides a get method for the current app state.

2. The State Management API provides a reduce method that accepts a reducer as a parameter. A reducer is a purely [^15] synchronous function that takes an instance of the AppState class as a parameter and returns a new instance of the AppState class as . When called, the reduce method executes the passed reducer with the current app state as a parameter and saves the return value of the reducer call as the new app state.

After presenting the State reducer pattern, the details of the components of the 'reduced' abstraction for state management frameworks now follow.

## Interface Reducer

Basis-Interface für die Implementierungen von App-Zustands-Änderungs-Operationen das die Signatur der Methode für die Ausführung solcher Operation festlegt. 

```dart
abstract class Reducer<S> {
  S call(S state);
}
```

Neben der Grundvariante des Interfaces gibt es weitere Varianten mit zusätzlichen Parametern für die App-Zustands-Änderungs-Operationen, z.B. mit einem Parameter:

```dart
abstract class Reducer1<S, V> {
  S call(S state, V value);
}
```

## Interface Reducible

Basis-Interface für State-Management-Instanzen mit einem Getter ```get state``` für den AppState und einer Methode ```reduce``` zum Aktualisieren des AppState entsprechend dem State-Reducer-Pattern. 

```dart
abstract class Reducible<S> {
  S get state;
  void reduce(Reducer<S> reducer);
}
```

## Interface Callable

Basis-Interface für Implementierungen von Callbacks. Die Implementierung von Callbacks als Klassen und nicht als Funktionen erlaubt das Überschreiben von ```get hashCode``` und ```operator==(other)```für Wertsemantik.

```dart
abstract class Callable<R> {
  R call();
}
```

Neben der Grundvariante des Interfaces gibt es weitere Varianten mit zusätzlichen Parametern für die Callbacks, z.B. mit einem Parameter:

```dart
abstract class Callable1<R, V> {
  R call(V value);
}
```

## Klasse ReducerOnReducible

Die Klasse implementiert das Interface ```Callable``` mit einem ```Reducer``` und einem ```Reducible``` indem bei Ausführung des Callbacks die Methode ```reduce``` des Reducible mit dem Reducer als Parameter ausgeführt wird.


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

Neben der Grundvariante des Klasse gibt es weitere Varianten mit zusätzlichen Parametern für die Callbacks, z.B. mit einem Parameter:

```dart
class Reducer1OnReducible<S, V> extends Callable1<void, V> {
  const Reducer1OnReducible(this.reducible, this.reducer);

  final Reducible<S> reducible;
  final Reducer1<S, V> reducer;

  @override call(value) =>
      reducible.reduce(Reducer1Adapter(reducer, value));

  @override get hashCode => ...
  @override operator ==(other) => ...
}
```

## Funktion wrapWithProvider

Die Funktion ```wrapWithProvider``` sorgt dafür, dass State-Management-Funktionalität für die nachfolgenden Widgets im Widget-Baum zugreifbar wird. 
<br/><br/>
Die Funktion hat immer einen Parameter ```child``` vom Typ Widget. Die komplette Signatur der Funktion ist abhängig vom State-Management-Framework,.
<br/><br/>
In der Implementierung wird das übergebene ```child```-Widget oft in ein sogenanntes 'Provider'-Widget eingepackt, welches im Widget-Baum den Zugriff auf eine State-Management-Instanz zur Verfügung stellt. 

## Funktion wrapWithConsumer

Die Funktion ```wrapWithConsumer``` sorgt dafür, dass der Rebuild eines Widgets durch das State-Management-Framework passend getriggert wird.
<br/><br/>
Die Funktion hat immer einen Parameter ```builder``` vom Typ Function mit dem Returntyp Widget. Die komplette Signatur der Funktion ist abhängig vom State-Management-Framework. 
<br/><br/>
‚In der Implementierung wird der übergebenene ```builder``` oft in ein sogenanntes 'Consumer'-Widget eingepackt, dass den ```builder``` genau dann ausführt, wenn sich relevante Properties der State-Management-Instanz ändern.
Die Funktion ```wrapWithConsumer``` ermöglichet es also, selektiv auf Zustandsänderungen zu lauschen.

## Fazit zur Anwendung des State-Reducer-Pattern

Auf Basis des State-Reducer-Pattern wurde eine minimale API für State-Management-Frameworks definiert,
die die grundlegenden State-Management-Anwendungsszenarien abdeckt.
Durch die Reduktion auf das Notwendige lässt sich die API leicht für existierende State-Management-Frameworks implementieren, wie später noch gezeigt wird.
Der Source-Code für die API kann hier gefunden werden: [github.com/partmaster/reduced](https://github.com/partmaster/reduced)
<br/><br/>
Da die 'reduced'-API für jedes konkrete State-Management-Framework nur einmal implementiert werden muss, verursacht sie keinen zusätzlichen Boilerplate-Code, sondern nur eine zusätzliche Abstraktionsschicht. 
Aber auch jede Abstraktionsschicht verursacht Aufwände, die gegenüber dem Nutzen abgewogen werden sollten.
<br/>
Die 'reduced'-API deckt nur den 'Standard-Teil' der APIs der State-Management-Frameworks ab. Jedes Framework bietet über die 'reduced'-API hinaus noch individuelle Features. Um auch solche Features nutzen zu können, kann man die 'reduced'-API erweitern oder an der 'reduced'-API vorbei direkt mit der Framework-API arbeiten.
<br/>
Falls in einem Projekt die Notwendigkeit für direkte Nutzung der State-Management-Framework-API kein Ausnahmefall bleibt, dann ist es wahrscheinlich, dass die Nutzung einer Abstraktionsschicht für das State-Management-Framework in so einem Projekt ungünstig ist. 

<div style="page-break-after: always;"></div>
# Teil 4<br/>Implementierung der 'reduced'-API

Eine Implementierung der 'reduced'-API für ein konkretes State-Management-Framework besteht aus der Implementierung des Interfaces ```Reducible``` sowie den Implementierungen der Funktionen ```wrapWithProvider```und ```wrapWithConsumer```. Optional kann noch eine Extension für den ```BuildContext``` hinzukommen, die einen bequemen Zugriff auf die State-Management-Instanz bereitstellt.

Wie eine 'reduced'-Implementierung aussieht, soll beispielhaft anhand der Frameworks 'Bloc' [^16] und 'Riverpod' [^17] gezeigt werden.

![reducer_action](images/reducer_action.png)
*Abb. 5: 'reduced'-API, API-Implementierungen und API-Verwendung*

## 'reduced'-API-Implementierung am Beispiel Bloc

Das State-Management-Framework 'Bloc' [^16] von Felix Angelov basiert auf dem Bloc-Pattern [^18] von Paolo Soares und Cong Hui.

### Reducible-Implementierung für Bloc

Das Framework Bloc implementiert State-Management-Instanzen mit der Klasse ```Bloc<E, S>```, wobei ```E``` der Typ-Parameter für State-Management-Ereignisse und ```S``` der Typ-Parameter für die Zustands-Klasse ist. Wir verwenden als Ereignis-Typ das Interface ```Reducer``` aus der 'reduced'-API. Da die ```Reducer``` ihre Operation auf dem App-Zustannd schon mitbringen, brauchen sie kein individuelles Dispatching, sondern sie können selbst ausgeführt werden. Die Methode ```S get state``` bringt die Klasse ```Bloc``` bereits mit und die Methode ```Reducible.reduce``` kann direkt auf die Methode ```Bloc.add``` abgebildet werden.  

```dart
class ReducibleBloc<S> extends Bloc<Reducer<S>, S>
    implements Reducible<S> {
  ReducibleBloc(super.initialState) {
    on<Reducer<S>>((event, emit) => emit(event(state)));
  }

  @override
  void reduce(Reducer<S> reducer) => add(reducer);

  late final reducible = this;
}
```

### Extension für dem BuildContext

```dart
extension ExtensionBlocOnBuildContext on BuildContext {
  ReducibleBloc<S> bloc<S>() =>
      BlocProvider.of<ReducibleBloc<S>>(this);
}
```

### wrapWithProvider-Implementierung für Bloc

Die Funktion wrapWithProvider erzeugt das Widget ```BlocProvider```.

```dart
Widget wrapWithProvider<S>({
  required S initialState,
  required Widget child,
}) =>
    BlocProvider(
      create: (_) => ReducibleBloc(initialState),
      child: child,
    );
```

### wrapWithConsumer-Implementierung für Bloc

Die Funktion ```wrapWithConsumer``` erzeugt das Widget ```BlocSelector```.
Die benötigte ```Reducible```-Instanz wird implizit übergeben, indem ```wrapWithConsumer``` als Extension der Klasse ```ReducibleBloc``` definiert wird.

```dart
extension WrapWithConsumer<S> on ReducibleBloc<S> {
  Widget wrapWithConsumer<P>({
    required ReducibleTransformer<S, P> transformer,
    required PropsWidgetBuilder<P> builder,
  }) =>
      BlocSelector<ReducibleBloc<S>, S, P>(
        selector: (state) => transformer(reducible),
        builder: (context, props) => builder(props: props),
      );
}
```

## 'reduced'-API-Implementierung am Beispiel Riverpod

Das State-Management-Framework 'Riverpod' [^17] von Remi Rousselet.

### Reducible-Implementierung für Riverpod

Das Framework Riverpod implementiert State-Management-Instanzen mit der Klasse ```StateNotifier<S>```, wobei ```S``` der Typ-Parameter für die Zustands-Klasse ist. Die Methode ```S get state``` bringt die Klasse ```StateNotifier``` bereits mit und die Methode ```Reducible.reduce``` kann einfach auf die Methode ```set state(S)``` abgebildet werden.  

```dart
class ReducibleStateNotifier<S> extends StateNotifier<S>
    implements Reducible<S> {
  ReducibleStateNotifier(super.state);

  late final Reducible<S> reducible = this;

  @override
  reduce(reducer) => state = reducer(state);
}
```

### Extension für dem BuildContext

Riverpod benötigt keine Extension für den BuildContext.

### wrapWithProvider-Implementierung für Riverpod

Die Funktion wrapWithProvider erzeugt das Widget ```ProviderScope```.

```dart
Widget wrapWithProvider({required Widget child}) =>
    ProviderScope(child: child);
```

### wrapWithConsumer-Implementierung für Riverpod

Die Funktion ```wrapWithConsumer``` erzeugt das Widget ```Consumer```.
Durch den Consumer bekommt man ein WidgetRef damit bekommt man bei jeder Änderund die aktuellen Props.

```dart
Widget wrapWithConsumer<S, P>({
  required StateProvider<P> provider,
  required PropsWidgetBuilder<P> builder,
}) =>
    Consumer(
      builder: (_, ref, __) => builder(props: ref.watch(provider)),
    );
```

### Tabelle der 'reduced'-API-Implementierungen

In der Flutter-Dokumentation sind aktuell 13 State Management Frameworks gelistet. Das Fish-Redux-Framework [^19] ist nicht Null-Safe [^20] und darum veraltet. Für die anderen 12 Frameworks wurde die 'reduced'-API exemplarisch implementiert. Die folgende Tabelle enthält Links zu diesen Frameworks und zu ihren 'reduced'-Implementierungen.

|Name|Publisher|'reduced'-Implementierung|
|---|---|---|
|[Binder](https://pub.dev/packages/binder)|[romainrastel.com](https://pub.dev/publishers/romainrastel.com)|[reduced_binder](https://github.com/partmaster/reduced/tree/main/approaches/reduced_binder)|
|[Fish Redux](https://pub.dev/packages/fish_redux)|[Alibaba](https://github.com/alibaba)|-|
|[Flutter Bloc](https://pub.dev/packages/flutter_bloc)|[bloclibrary.dev](https://pub.dev/publishers/bloclibrary.dev)|[reduced_bloc](https://github.com/partmaster/reduced/tree/main/approaches/reduced_bloc)|
|[Flutter Command](https://pub.dev/packages/flutter_command)|[escamoteur](https://github.com/escamoteur)|[reduced_fluttercommand](https://github.com/partmaster/reduced/tree/main/approaches/reduced_fluttercommand)|
|[Flutter Triple](https://pub.dev/packages/flutter_triple)|[flutterando.com.br](https://pub.dev/publishers/flutterando.com.br/packages)|[reduced_fluttertriple](https://github.com/partmaster/reduced/tree/main/approaches/reduced_fluttertriple)|
|[GetIt](https://pub.dev/packages/get_it)|[fluttercommunity.dev](https://pub.dev/publishers/fluttercommunity.dev)|[reduced_getit](https://github.com/partmaster/reduced/tree/main/approaches/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[getx.site](https://pub.dev/publishers/getx.site)|[reduced_getx](https://github.com/partmaster/reduced/tree/main/approaches/reduced_getx)|
|[MobX](https://pub.dev/packages/flutter_mobx)|[dart.pixelingene.com](https://pub.dev/publishers/dart.pixelingene.com)|[reduced_mobx](https://github.com/partmaster/reduced/tree/main/approaches/reduced_mobx)|
|[Provider](https://pub.dev/packages/provider)|[dash-overflow.net](https://pub.dev/publishers/dash-overflow.net)|[reduced_provider](https://github.com/partmaster/reduced/tree/main/approaches/reduced_provider)|
|[Redux](https://pub.dev/packages/flutter_redux)|[brianegan.com](https://pub.dev/publishers/brianegan.com)|[reduced_redux](https://github.com/partmaster/reduced/tree/main/approaches/reduced_redux)|
|[Riverpod](https://pub.dev/packages/flutter_riverpod)|[dash-overflow.net](https://pub.dev/publishers/dash-overflow.net)|[reduced_riverpod](https://github.com/partmaster/reduced/tree/main/approaches/reduced_riverpod)|
|[Solidart](https://pub.dev/packages/flutter_solidart)|[bestofcode.dev](https://pub.dev/publishers/bestofcode.dev)|[reduced_solidart](https://github.com/partmaster/reduced/tree/main/approaches/reduced_solidart)|
|[States Rebuilder](https://pub.dev/packages/states_rebuilder)|[Mellati Fatah](https://github.com/GIfatahTH)|[reduced_statesrebuilder](https://github.com/partmaster/reduced/tree/main/approaches/reduced_statesrebuilder)|

## Fazit zur Implementierung der 'reduced'-API

Die Ziel der 'reduced'-API ist eine minimale Abstraktionsschicht für State-Management-Frameworks.   
Der geringe Code-Umfang und die direkten Abbildungern in den Implementierungen der 'reduced'-API zeigen, dass dieses Ziel erreicht wurde. Die 'reduced'-API passt sehr gut auf die meisten Frameworks. 
<br/>
Beim State-Management-Framework MobX [^21] musste allerdings, um die Funktionen ```wrapWithProvider``` und ```wrapWithConsumer``` bereitzustellen, gegen das Framework gearbeitet werden: Die 'reduced'-API-Funktionen sind so ausgelegt, dass sie die State-Management-Instanzen mit generischen Klassen zur Laufzeit erstellen und benutzen. Dagegen verwendet MobX spezifische State-Management-Klassen, die bereits beim Build mit einem Code-Generator generiert werden. 
<br/><br/>
Durch die Verwendung der 'reduced'-API wird neben der Trennung von Verantwortlichkeiten auch eine Unabhängigkeit vom State-Management-Framework möglich: die refaktorisierte Counter-Demo-App läuft mit allen 12 gelisteten und verfügbaren Frameworks. In der Datei [binder.dart](https://github.com/partmaster/reduced/blob/30dbd8c3060b5d46ddcd160c19d8c00badd06e2a/examples/counter_app/lib/view/binder.dart) kann das in der Counter-Demo-App verwendete State-Management-Framework umgeschaltet werden, indem die entsprechende ```export```-Anweisung ausgeführt (vom den Kommentar-Zeichen befreit) wird:

```dart
// export 'binder/binder_binder.dart';
// export 'binder/bloc_binder.dart';
// export 'binder/fluttercommand_binder.dart';
// export 'binder/fluttertriple_binder.dart';
// export 'binder/getit_binder.dart';
// export 'binder/getx_binder.dart';
// export 'binder/mobx_binder.dart';
// export 'binder/provider_binder.dart';
// export 'binder/redux_binder.dart';
// export 'binder/riverpod_binder.dart';
// export 'binder/setstate_binder.dart';
// export 'binder/solidart_binder.dart';
export 'binder/statesrebuilder_binder.dart';
```

<div style="page-break-after: always;"></div>
# Offene Enden

## Grauzonen zwischen UI und App-Logik

Zur Implementierung einiger UI-Aktionen benötigt man einen [BuildContext]. Ein prominentes Beispiel ist die Navigation zwischen App-Seiten mit [Navigator.of(BuildContext)]. Die Entscheidung, wann zu welcher App-Seite navigiert wird, ist App-Logik. Die App-Logik sollte möglichst ohne Abhängigkeiten von der UI-Ablaufumgebung bleiben, und ein [BuildContext] repräsentiert quasi diese Ablaufumgebung. 
</br></br>
Ein ähnliches Problem sind UI-Ressourcen wie Bilder, Icons, Farben und Fonts, die eine Abhängigkeit zur UI-Ablaufumgebung besitzen und deren Bereitstellung UI-App-Logik erfordern kann. 
Zwischen UI-Code und App-Logik-Code gibt es also noch Grauzonen, die in klare Abgrenzungen umgewandelt werden sollten. (Im Fall des [Navigator]s gibt es mit dem Property [MaterialApp.navigatorKey] einen möglichen Workaround für die Navigation zwischen App-Seiten ohne [BuildContext].) 
 
## Lokale bzw. geschachtelte App-Zustände

Der Ansatz, den kompletten App-Zustand als unveränderliche Instanz einer einzigen Klasse zu modellieren, wird bei sehr komplexen Datenstrukturen, sehr großen Datenmengen oder sehr häufigen Änderungsaktionen an seine Grenzen kommen [^22].
</br></br>
In der redux.js-Dokumentation gibt es Hinweise [^23], [^24], wie man diese Grenzen durch eine gute Strukturierung der App-Zustands-Klasse erweitern kann.
</br></br>
Letztlich kann man versuchen, Performance-kritische Teile aus dem globalen App-Zustand zu extrahieren und mit lokalen State-Management-Lösungen umzusetzen. 
Im State-Management-Framework Fish-Redux [^19] ist es z.B. grundsätzlich so, dass (neben einen globalen App-Zustand) für jede App-Seite eine lokale State-Management-Instanz existiert.  

## UI-Code-Strukturierung

In diesem Artikel wurden Code-Struktur und Entwurfsmuster für eine Trennung der Verantwortlichkeiten von UI-Code und App-Logik-Code diskutiert. 
</br></br>
Eine separierte App-Logik kann man mit allen verfügbaren Architektur-Ansätzen und Entwurfmustern weiterstrukturiert werden.
</br></br>
Für den separierten Flutter-UI-Code werden allerdings für größere Projekte weitere  Strukturierungskonzepte benötigt:

* Wie separiere ich das Theming, z.B. Light Mode und Dark Mode?

* Wie separiere ich die Layout-Adaptionen für verschiedene Endgeräte-Gruppen, z.B. Smartphone, Tablet, Desktop, Drucker ? 

* Wie separiere ich den Code für die Layout-Responsivness für Änderungen der App-Display-Größe zwischen den Adaptionsstufen ?

* Wie separiere ich den Code für Animationen?

## Praxis-Erprobung

Die in diesem Artikel vorgestellte Code-Struktur ist ein Ergebnis meiner Erfahrungen aus kleinen und mittleren Flutter-Projekten. Eines davon ist das Projekt Cantarei - die Taizé-Lieder-App. Die App ist frei im Apple- [^25] und im Google- [^26] App-Store verfügbar, so dass jeder Interessierte selbst einen Eindruck gewinnen kann, für welche Projekt-Größen die hier vorgeschlagenen Konzepte bereits praxiserprobt sind. Ob sie sich, so wie sie sind, mit Erfolg auf viele und vor allem auch auf größere Projekte anwenden lassen, muss sich erst noch erweisen.

# Schlußwort

In der Software-Entwicklung ist Übermotivation ungünstig. Jede Abstraktion zum Verbergen von Abhängigkeiten verursacht Kosten und sollte genug Vorteile bringen, um die Kosten zu rechtfertigen [^27]. Ich hoffe, die 'reduced'-Abstraktion, insbesondere in Kombination mit der Anwendung des Humble-Object-Pattern, ist den Aufwand wert.

<div style="page-break-after: always;"></div>
# Referenzen

[^1]: Flutter</br> [flutter.dev](https://flutter.dev/)

[^2]: Alles ist ein Widget</br> [docs.flutter.dev/development/ui/layout](https://docs.flutter.dev/development/ui/layout)

[^3]: Clean-Code</br> [de.wikipedia.org/wiki/Clean_Code](https://de.wikipedia.org/wiki/Clean_Code)

[^4]: Trennung der Verantwortlichkeiten</br> [en.wikipedia.org/wiki/Separation_of_concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)

[^5]: Boilerplate Code [de.wikipedia.org/wiki/Boilerplate-Code](https://de.wikipedia.org/wiki/Boilerplate-Code)

[^6]: Humble Object Pattern</br> [xunitpatterns.com/Humble Object.html](http://xunitpatterns.com/Humble%20Object.html)

[^7]: Vor dem Humble-Object-Pattern [livebook.manning.com/book/unit-testing/chapter-7/49](https://livebook.manning.com/book/unit-testing/chapter-7/49)

[^8]: Nach dem Humble-Object-Pattern [livebook.manning.com/book/unit-testing/chapter-7/51](https://livebook.manning.com/book/unit-testing/chapter-7/51)

[^9]: Flutter State Management Approaches</br> [docs.flutter.dev/development/data-and-backend/state-mgmt/options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)

[^10]: Wertsemantik</br> [en.wikipedia.org/wiki/Value_semantics](https://en.wikipedia.org/wiki/Value_semantics)

[^11]: Faltungsfunktion</br> [www.cs.nott.ac.uk/~gmh/fold.pdf](http://www.cs.nott.ac.uk/~gmh/fold.pdf)

[^12]: Redux</br> [redux.js.org/](https://redux.js.org/)

[^13]: Reducer Pattern</br> [redux.js.org/tutorials/fundamentals/part-3-state-actions-reducers](https://redux.js.org/tutorials/fundamentals/part-3-state-actions-reducers)

[^14]: Prinzip des State-Reducer-Pattern (killalldefects.com/2019/12/28/rise-of-the-reducer-pattern/)[https://killalldefects.com/2019/12/28/rise-of-the-reducer-pattern/]

[^15]: Pure Funktion</br> [en.wikipedia.org/wiki/Pure_function](https://en.wikipedia.org/wiki/Pure_function)

[^16]: Bloc</br> [bloclibrary.dev](https://bloclibrary.dev/)

[^17]: Riverpod</br> [riverpod.dev](https://riverpod.dev/)

[^18]: Bloc Pattern<br/> [www.youtube.com/watch?v=PLHln7wHgPE](https://www.youtube.com/watch?v=PLHln7wHgPE)

[^19]: Fish Redux [pub.dev/packages/fish_redux](https://pub.dev/packages/fish_redux)

[^20]: Null Safety [dart.dev/null-safety#enable-null-safety](https://dart.dev/null-safety#enable-null-safety)

[^21]: MobX [mobx.netlify.app/](https://mobx.netlify.app/)

[^22]: Reducer Pattern Nachteil</br> [twitter.com/acdlite/status/1025408731805184000](https://twitter.com/acdlite/status/1025408731805184000)

[^23]: App-Zustands-Gliederung</br> [redux.js.org/usage/structuring-reducers/basic-reducer-structure](https://redux.js.org/usage/structuring-reducers/basic-reducer-structure)

[^24]: App-Zustands-Normalisierung</br> [redux.js.org/usage/structuring-reducers/normalizing-state-shape](https://redux.js.org/usage/structuring-reducers/normalizing-state-shape)

[^25]: Die App *Cantarei* im Apple-Appstore [apps.apple.com/us/app/cantarei/id1624281880](https://apps.apple.com/us/app/cantarei/id1624281880)

[^26]: Die App *Cantarei* im Google-Playstore [play.google.com/store/apps/details?id=de.partmaster.cantarei](https://play.google.com/store/apps/details?id=de.partmaster.cantarei)

[^27]: Unnötige Abstraktionen [twitter.com/remi_rousselet/status/1604603131500941317](https://twitter.com/remi_rousselet/status/1604603131500941317)
