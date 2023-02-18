# Die Abstraktion 'Reducible' </br> für das State Management in Flutter

## Autor

Steffen Nowacki · PartMaster GmbH · [www.partmaster.de](https://www.partmaster.de)

## Abstract

Hier wird die Abstraktion 'Reducible' vorgestellt, die UI und Logik einer Flutter-App 
vom verwendeten State Management Framework entkoppelt. State Management Frameworks dienen der Trennung von UI und Logik. Sie haben oft die Nebenwirkung, UI und Logik zu infiltrieren und dadurch ungünstige Abhängigkeiten zu erzeugen. Dem soll die Abstraktion entgegenwirken.
'Reducible' basiert auf der Kombination der Entwurfsmuster "State Reducer" und "Humble Objekt" und verwendet die Bausteine AppState, Reducer und Reducible sowie Binder, Builder und Props, die im Folgenden erklärt werden.
Die entstehende Code-Struktur ist gut testbar, skalierbar und kompatibel zu verbreiteten State Management Frameworks, wie Riverpod [^4] oder Bloc [^5]. 
</br> 
Wer beim Einsatz von State Management Frameworks flexibel bleiben will oder wer seine Widget-Baum-Code-Struktur übersichtlicher gestalten will, oder wer sich einfach nur einen Überblick über verfügbare State Management Frameworks verschaffen will, für den könnte der Artikel interessant sein. 

## Einleitung

Source Code scheint dem 2. Gesetz der Thermodynamik zu folgen und zur Aufrechterhaltung der Ordnung der ständigen Zuführung von äußerer Energie zu bedürfen. 
Flutter-App-Projekte sind da keine Ausnahme. Ein typisches Symptom sind build-Methoden mit wachsenden Widget-Konstruktor-Hierarchien, die von App-Logik infiltriert werden.
Mit App-Logik meine ich die Fachlogik der UI und ihres Zustands im engeren Sinn - in Abgrenzung zur Fachlogik einer Anwendungsdomäne, die oft in Datenbanken, Backends oder externen Bibliotheken implementiert ist. 
Viele Flutter-Frameworks wurden und werden entwickelt, um eine saubere Architektur [^23] zu unterstützen. Dabei geht es hauptsächlich um die eine Trennung der Verantwortlichkeiten [^2] zwischen App-Logik und UI beim Verwalten des Zustandes der App.  
Bei einem unbedachten Einsatz solcher Frameworks besteht die Gefahr, dass sie neben ihrer eigentlichen Aufgabe, der Trennung der Verantwortlichkeiten, die App-Logik und die UI infiltrieren und unerwünschte Abhängigkeiten schaffen.
Weil es viele Frameworks gibt (in der offiziellen Flutter-Dokumentation sind aktuell 13 Frameworks gelistet [^6]) und die Entwicklung sicher noch nicht abgeschlossen ist, kann es besonders für große und langlebige App-Projekte zur Herausforderung werden, zwischen Frameworks migrieren oder verschiedene Frameworks integrieren zu müssen.  
</br>
Im Folgenden wird eine Abstraktion für Flutter-Apps vorgestellt, die solche unerwünschten Infiltrationen vermeidet und so die Qualität von App-Logik- und UI-Code verbessert. Dabei geht es ausdrücklich nicht um die Einführung eines weiteren Frameworks sondern um die abgestimmte Anwendung von zwei Entwurfsmustern [^1], Humble Object [^7] und State Reducer [^8], auf den Flutter-App-Code. 
</br>
Flutter [^3] beschreibt sich selbst mit dem Spruch "Alles ist ein Widget" [^9]. Damit ist gemeint, dass alle Features in Form von Widget-Klassen implementiert sind, die sich wie Lego-Bausteine aufeinander stecken lassen. Das ist eine großartige Eigenschaft mit einer kleinen Kehrseite: Wenn man nicht aufpasst, vermischen sich in den resultierenden Widget-Bäumen schnell die Verantwortlichkeiten. 

Die Verantwortlichkeiten um die es in diesem Dokument geht, sind einerseits die klassischen UI-Aufgaben: 

1. Layout, 

2. Rendering, 

3. Gestenerkennung 

und andererseits Aufgaben die sich auf den App-Zustand beziehen:

4. Lauschen auf App-Zustands-Änderungen,  

5. Konvertierung des App-Zustandes in Anzeige-Properties, 

6. Abbildung von Gesten auf App-Zustands-Operationen. 

Die UI-Aufgaben sind eng an eine Umgebung gebunden, in der User Interfaces ablaufen können, wohingegen die Logik in den App-Zustands-Aufgaben nicht unbedingt an eine UI-Ablaufumgebung gebunden ist.

## AppState, Reducer und Reducible

Das erste Ziel der Abstraktion ist, den Code so zu strukturieren, dass die App-Logik vom eingesetzten Zustands-Verwaltungs-Framework und von Flutter allgemein separiert wird.
Um das zu erreichen, wird das State Reducer Pattern angewandt. 
</br>
Einfach ausgedrückt beinhaltet dieses Pattern die Forderung, dass jede Änderung am App-Zustand als atomare Operation mit dem aktuellen App-Zustand als Parameter und einem neuen App-Zustand als Resultat ausgeführt wird. Aktionen, die potenziell länger laufen (Datenbank-Anfragen, Netzwerk-Aufrufe, ..), müssen wegen dieser Forderung meist mit mehreren atomaren App-Zustands-Änderungen umgesetzt werden, z.B. eine am Beginn der Aktion und eine am Ende. Entscheidend ist, dass die App-Zustands-Änderung am Ende der Aktion nicht das App-Zustands-Resultat vom Anfang der Aktion als Parameter (wieder-)verwendet, sondern den dann aktuellen App-Zustand des App-Zustands-Verwaltungs-Frameworks. Das Pattern unterstützt diese Absicht, indem es dafür sorgt, dass man bei einer Änderung den aktuellen App-Zustand nicht selbst holen muss, sondern unaufgefordert geliefert bekommt.
</br>
Oder etwas analytischer ausgedrückt: Das State Reducer Pattern modelliert den App-Zustand als Ergebnis einer Faltungsfunktion [^14] aus dem initialen App-Zustand und der Folge der bisherigen App-Zustands-Änderungs-Aktionen. 
<br>
Dan Abramov und Andrew Clark haben dieses Konzept im Javascript-Framework Redux [^10] verwendet und für den Kombinierungsoperator, der aus dem aktuellen App-Zustand und einer Aktion einen neuen App-Zustand berechnet, den Namen *Reducer* populär gemacht [^8]:  

> Reducers sind Funktionen, die den aktuellen Zustand und eine Aktion als Argumente nehmen und ein neues Zustandsergebnis zurückgeben.</br> 
Mit anderen Worten: `(state, action) => newState`.

![reducer](images/reducer_killalldefectscom.png)
</br>
*Bildquelle: killalldefects.com*

Auf App-Code bezogen heißt das:

1. Für den App-Zustand wird eine AppState-Klasse definiert - eine reine Datenklasse mit ausschließlich finalen Feldern und einem const Konstruktor. Die App-Zustands-Verwaltung stellt eine get-Methode für den aktuellen App-Zustand zur Verfügung.  

2. Die App-Zustands-Verwaltung stellt eine reduce-Methode zur Verfügung, die einen Reducer als Parameter akzeptiert. Ein Reducer ist eine reine [^11] synchrone Funktion, die eine Instanz der AppState-Klasse als Parameter bekommt und eine neue Instanz der AppState-Klasse als zurückgibt. Beim Aufruf führt die reduce-Methode den übergebenen Reducer mit dem aktuellen App-Zustand als Parameter aus und speichert den Rückgabewert des Reducer-Aufrufs als neuen App-Zustand ab. 

3. Die App-Zustands-Verwaltung stellt der UI eine Möglichkeit zur Verfügung, sich über Zustandsänderungen benachrichtigen zu lassen. Als Minimalanforderung reicht es aus, wenn als Benachrichtigung in einem Widget ein [setState](https://api.flutter.dev/flutter/widgets/State/setState.html) oder [markNeedsBuild](https://api.flutter.dev/flutter/widgets/Element/markNeedsBuild.html) ausgelöst wird. Diese Benachrichtigung sollte auch selektiv nur für ausgesuchte Änderungen am App-Zustand möglich sein.  

Für die ersten beiden Anforderungen lässt sich leicht eine Abstraktion definieren:

1. eine get-Methode für den App-Zustand

2. eine reduce-Methode zum Ändern des App-Zustands 

Um die Abstraktion leicht auf vorhandene App-Zustands-Verwaltungs-Lösungen aufsetzen zu können, wurde sie nicht als abstrakte Basisklasse sondern als Proxy nach dem gleichnamigen Entwursmuster [^22] modelliert. Die Identität der realen App-Zustands-Verwaltungs-Instanz wird im Proxy durch das Property `identity` repräsentiert  

```dart
class Reducible<S> {
  const Reducible(this.getState, this.reduce, this.identity);

  final S Function() getState;
  final Reduce<S> reduce;
  final Object identity;

  @override
  int get hashCode => identity.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Reducible<S> && identity == other.identity;
}
```

Hier noch die Definition der in `Reducible`verwendeten Typen `Reducer` und `Reduce`:

```dart
abstract class Reducer<S> {
  const Reducer();

  S call(S state);
}

typedef Reduce<S> = void Function(Reducer<S>);
```

Wenn wir davon ausgehen, dass jedes App-Zustands-Verwaltungs-Framework in irgendeiner Form eine Get- und eine Set-Methode für den App-Zustand anbietet, dann lässt sich die reduce-Methode `void reduce(Reducer)` aus dem Interface `Reducible` einfach implementieren:

```dart
  void reduce(Reducer<MyAppState> reducer) => 
    setState(reducer(getState()));
```

Das Reducer-Pattern sollte sich also einfach mit jedem App-Zustands-Verwaltungs-Framework umsetzten lassen. 

Die Umsetzung der dritten Anforderung, sich über Änderungen am App-Zustand benachrichtigen lassen zu können, ist stark vom eingesetzten App-Zustands-Verwaltungs-Framework abhängig (insbesondere die selektive Benachrichtigung) und wird später für ausgewählte Lösungen (StatefulWidget/InheritedWidget, Riverpod, Bloc) diskutiert. 

![reducer_action](images/reducer_action.png)

Mit Hilfe des vorgestellten Konzepts mit den Klassen AppState, Reducer und Reducible sollte es möglich sein, die App-Logik komplett vom ausgewählten Zustands-Verwaltungs-Framework zu entkoppeln. Die App-Logik wird hauptsächlich in Form von verschiedenen Reducer-Implementierungen bereitgestellt.
Der Rest der App-Logik liegt in Konvertierungsfunktionen, die aus einem Reducible und den Reducer-Implementierungen die verschiedenen Props-Klassen erzeugen, die im folgenden Kapitel vorgestellt werden. 

## Builder, Binder und Props

Das zweite Ziel der hier vorgestellen Abstraktion ist, den Flutter-Code so zu strukturieren, dass im Code für die Widget-Bäume die UI-Aufgaben streng von den App-Zustands-Aufgaben separiert werden und die Abhängigkeit des UI-Codes vom App-Zustands-Verwaltungs-Framework minimiert wird.
Um das zu erreichen, wird das Humble Object Pattern von Micheal Feathers [^13] angewandt.
Die Zusammenfassung des Humble Object Pattern lautet: 

> Wenn Code nicht gut testbar ist, weil er zu eng mit seiner Umgebung verbunden ist, extrahiere die Logik in eine separate, leicht zu testende Komponente, die von ihrer Umgebung entkoppelt ist.

#### Ausgangslage des Humble Object Pattern

![humble1](images/humble1.png)
</br>
*Bildquelle: manning.com*

#### Lage nach Anwendung des Humble Object Pattern

![humble2](images/humble2.png)
</br>
*Bildquelle: manning.com*

Auf eine Flutter-Widget-Klasse bezogen, habe ich das Pattern folgendermaßen angewendet: 

1. Wenn die Widget-Klasse sowohl UI-Aufgaben als auch 
App-Zustands-Aufgaben löst, dann wird diese Widget-Klasse in eine Builder-Klasse, eine Binder-Klasse, eine Props-Klasse und eine Konverterfunktion zur Erzeugung von Props-Instanzen geteilt.

2. Die Builder-Klasse ist ein StatelessWidget. Sie bekommt von der Binder-Klasse im Konstruktor die Props-Instanz mit vorkonfektionierten Properties und Callbacks und erzeugt in der build-Methode einen Widget-Baum aus Layout-, Renderer und Gestenerkennungs-Widgets.

3. Die Binder-Klasse lauscht bei der App-Zustands-Verwaltung selektiv auf Änderungen 'ihrer' Props und liefert in der build-Methode ein Widget der Builder-Klasse zurück. 

4. Für die vorkonfektionierten Properties und Callbacks der Builder-Klasse wird eine Props-Klasse definiert - eine reine Datenklasse mit ausschließlich finalen Feldern.

5. Für die Props-Klasse wird eine Konverter-Funktion definiert, die aus dem aktuellen App-Zustand die Werte für die Properties und aus den den Reducer-Implementierungen die Werte für die Callbacks erzeugt.

![humble_widget](images/humble_widget.png)

Zusammengefasst: 
Wegen ihrer inhärenten Abhängigkeit von der UI-Umgebung repräsentiert die Builder-Klasse das Humble-Object.
Das Lauschen der Binder-Klasse auf selektive Änderungen und die Konverterfunktion für die Erzeugung der Props-Instanzen repräsentieren die extrahierte Logik aus dem Humble-Object-Pattern.

## Examples

Nun soll die vorgestellte Abstraktion und die resultierende Code-Struktur an einem kleinen Beispiel illustriert werden. 

### Ausgangslage

Als Vorlage dient das wohlbekannte Flutter-Counter-App-Projekt. In diesem Projekt spielt die Klasse _MyHomePageState die zentrale Rolle:

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
Die Klasse _MyHomePageState trägt die verschiedensten Verantwortungen: 

1\. Layout

```dart
          mainAxisAlignment: MainAxisAlignment.center,
```

2\. Rendering 

```dart
              style: Theme.of(context).textTheme.headline4,
```

3\. Gestenerkennng

```dart
        onPressed:
```

4\. App-Zustands-Speicherung

```dart
  int _counter = 0;
```

5\. Bereitstellung von Operationen für App-Zustands-Änderungen

```dart
  void _incrementCounter() {
```

6\. Widget-Benachrichtigung nach App-Zustands-Änderungen

```dart
    setState(() {
```

7\. Konvertierung des App-Zustands in Anzeige-Properties

```dart
              '$_counter',
```

8\. Abbildung von Gesten-Callbacks auf App-Zustands-Änderungens-Operationen

```dart
        onPressed: _incrementCounter,
```

### Props

Wir wollen nun die Code-Struktur von `_MyHomePageState` verbessern und beginnen mit der Definition einer neuen Klasse, der Props. Die Props sind eine Datenklasse für eine korrespondierende Widget-Klasse, die alle in der build-Methode der Widget-Klasse zur Erstellung des Widget-Baums benötigten Properties enthält. Die Property-Namen in der Props-Klasse werden so gewählt, dass eine leichte Zuordnung zu den Properties im Widget-Baum, denen sie zugewiesen werden sollen, möglich ist.
Der Name *Props* ist eine in React [^18] übliche Abkürzung für die Properties von StatelessWidgets und die unveränderlichen Properties (im Gegensatz zu veränderbaren Status-Properties) von StatefulWidgets.
</br>
Für die Klasse `_MyHomePageState` könnte die zugehörige Props-Klasse so aussehen:

```dart
class MyHomePageProps {
  final String title;
  final String counterText;
  final Callable<void> onIncrementPressed;

  MyHomePageProps({
    required this.title,
    required this.counterText,
    required this.onIncrementPressed,
  });

  @override
  int get hashCode => hash3(title, counterText, onIncrementPressed);

  @override
  bool operator ==(Object other) =>
      other is MyHomePageProps &&
      title == other.title &&
      counterText == other.counterText && 
      onIncrementPressed == other.onIncrementPressed;
}
``` 

### Konverter 

Um aus dem App-Zustand einen Props-Wert zu erzeugen, bedarf es einer Konvertierung. Diese Konvertierung ist der static Methode `MyHomePagePropsConverter.convert` implementiert. In dieser Methode wird festgelegt, wie App-Zustands-Werte für die Anzeige kombiniert bzw. formatiert werden und auf welche App-Zustands-Operationen die erkannten Nutzergesten in den Nutzergesten-Callbacks abgebildet werden. 

```dart
class MyHomePagePropsConverter {
  static MyHomePageProps convert(Reducible<MyAppState> reducible) =>
      MyHomePageProps(
        title: reducible.getState().title,
        counterText: '${reducible.getState().counter}',
        onIncrementPressed: BondedReducer(
          reducible,
          IncrementCounterReducer(),
        ),
      );
}
```

Damit die Props als Wert für selektive Benachrichtigungen über App-Zustands-Änderungen eingesetzt werden können, müssen die [hashCode](https://api.dart.dev/stable/2.13.4/dart-core/Object/hashCode.html) und [operator==](https://api.dart.dev/stable/2.13.4/dart-core/Object/operator_equals.html) Methoden der Props-Klasse nach Wertsemantik [^12] funktionieren. Das setzt voraus, dass diese Methoden bei allen Properties ebenfalls nach Wertsemantik funktionieren. Da mir nicht ganz klar ist, wie dies bei Funktionsobjekten gewährleistet werden kann, habe ich für das Callback-Property nicht den Standard-Flutter-Typ [VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html) verwendet, sondern eine eigene Klasse `Callable<void>` mit überschriebenen [hashCode](https://api.dart.dev/stable/2.13.4/dart-core/Object/hashCode.html) und [operator==](https://api.dart.dev/stable/2.13.4/dart-core/Object/operator_equals.html) Methoden.  

```dart
abstract class Callable<T> {
  T call();
}

class BondedReducer<S> extends Callable<void> {
  BondedReducer(this.reducible, this.reducer);

  final Reducible<S> reducible;
  final Reducer<S> reducer;

  @override
  void call() => reducible.reduce(reducer);

  @override
  int get hashCode => hash2(reducible, reducer);

  @override
  bool operator ==(Object other) =>
      other is VoidCallable<S> &&
      reducer == other.reducer &&
      reducible == other.reducible;
}
```

### Builder

Die Builder-Klasse ist für den Bau des Widget-Baums aus Layout-, Rendering- und Gestenerkennungs-Widgets verantwortlich. Dazu verwendet sie eine Instanz vom Typ der korrespondierenden Props-Klasse, die ihr im Konstruktor übergeben wird.
Mit Hilfe der vorkonfektionierten Properties in den Props lässt sich nun leicht aus der _MyHomePageState-Klasse eine stateless Builder-Klasse für den Widget-Baum extrahieren.

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
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                props.counterText,
                style: Theme.of(context).textTheme.headline4,
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
### Binder

Zu jeder Builder-Klasse gibt es eine korrespondierende Binder-Klasse. Die Binder-Klasse ist für die Bindung an den App-Zustand verantwortlich. Sie muss dafür sorgen, dass bei einer Änderung des App-Zustandes neue Props erzeugt werden und mit diesen Props eine neue Instanz der Builder-Klasse gebaut wird. Wie sie das umsetzt, hängt vom verwendeten App-Zustands-Verwaltungs-Framework ab. Für das Beispiel nutzen wir für den Anfang kein externes Framework wie Riverpod oder Bloc, sondern nur StatefulWidget und InheritedWidget. Die in der build-Methode von `MyHomePageBinder` verwendete InheritedValueWidget-Klasse, eine Ableitung der InheritedWidget-Klasse, wird im Abschnitt *App-Zustandsverwaltung* vorgestellt.  

```dart
class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => MyHomePageBuilder(
        props: InheritedValueWidget.of<MyHomePageProps>(context),
      );
}
```
Die Binder-Klasse setzt also in der abgebildeten Implementierung voraus, dass das InheritedWidget `InheritedValueWidget` die aktuellen Props bereitstellt und dass ein StatefulWidget das InheritedWidget mit dem aktuellen App-Zustand versorgt. Unter diesen Voraussetzungen ist die Binder-Klasse seht einfach.

### AppState

Der AppState beinhaltet das Property `counter`. Da im Flutter-Counter-App-Projekt auch der `title` von außen an das _MyHomePageState-Widget übergeben wird, habe ich es ebenfalls in den AppState mit aufgenommen, obwohl der `title` nie geändert wird.

```dart
class MyAppState {
  const MyAppState({required this.title, this.counter = 0});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );

  @override
  int get hashCode => Object.hash(title, counter);

  @override
  bool operator ==(Object other) =>
      other is MyAppState && title == other.title && counter == other.counter;
}
```

### Reducer

Die Klasse _MyHomePageState aus dem Flutter-Counter-App-Projekt hat für Änderungen am App-Zustand nur die eine Methode `incrementCounter`. Da es sich hier um App-Logik in einer Klasse mit UI-Aufgaben handelt, wird der Code in eine neue Klasse `IncrementCounterReducer` ausgelagert. Von der Basisklasse `Reducer` wird für alle Reducer-Implementierungen die reducer-Methode `call` mit der Signatur `S call(S)` vorgegeben. Als konkrete App-Logik wird in der Methode `call` in der Klasse `IncrementCounterReducer` das Property `counter` im AppState inkrementiert. 
</br>
Einige AppState-Verwaltungs-Frameworks entkoppeln die UI von der direkten Zuordnung eines Ereignisses (meist eine erkannte Geste) zu einer App-Logik-Operation, indem die UI Event-Instanzen versendet, um eine Anforderung über eine Operation am AppState auszulösen. 
In solchen Frameworks mit Event-Klassen können die Reducer-Instanzen als Events verwendet werden. Es gibt in der hier vorgestellten Code-Struktur trotzdem kein Kopplungsproblem zwischen UI und App-Logik, weil diese Entkopplung schon durch die Callback-Properties in den Props-Klassen erreicht werden. 
Wegen der potenziellen Verwendung als Events müssen die Reducer-Instanzen Wertsemantik haben. Wenn sichergestellt ist, dass es für eine Reducer-Klasse nur eine Instanz gibt, genügen statt Wertsemantik die geerbten hashCode und operator== Methoden.

```dart
class IncrementCounterReducer extends Reducer<MyAppState> {
  IncrementCounterReducer._();
  factory IncrementCounterReducer() => instance;

  static final instance = IncrementCounterReducer._();

  @override
  MyAppState call(state) => state.copyWith(counter: state.counter + 1);
}
```

### App-Zustandsverwaltung

Die Umsetzung der App-Zustands-Verwaltung für die Beispiel-App ist stark vom verwendeten App-Zustands-Verwaltungs-Framework abhängig. Zunächst soll eine Umsetzung mit StatefulWidget und InheritedWidget, also ohne externes Framework gezeigt werden.
Für die Implementierung der App-Zustands-Verwaltung mit einer Kombination aus StatefulWidget und InheritedWidget werden die Hilfsklassen `AppStateBinder` und `InheritedValueWidget` eingeführt.

#### AppStateBinder

Die Klasse `AppStateBinder` erbt von StatefulWidget und hält im Feld _state den veränderlichen App-Zustand. Sie stellt eine get-state-Methode für den App-Zustand sowie eine reduce-Methode, um den App-Zustand von außen mit einem Reducer verändern zu können, bereit. Die beiden Methoden `get state` und `reduce` werden in ein `Reducible` verpackt und sind in der hier vorgestellten Code-Struktur die generelle Schnittstelle der App-Zustands-Verwaltung nach außen. Das `Reducible` wird von `AppStateBinder` an den im Konstruktor hereingereichten `builder` zum Bau des child-Widgets übergeben. Dieser `builder` wird im später vorgestellten  `MyAppStateBinder` dazu genutzt werden, InheritedWidget-Kinder zu erzeugen und sie dabei mit dem `Reducible` zu versorgen. 

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
      // ignore: no_logic_in_create_state
      _ReducibleStatefulWidgetState<S>(initialState);
}
```

```dart
class _ReducibleStatefulWidgetState<S>
    extends State<ReducibleStatefulWidget<S>> {
  _ReducibleStatefulWidgetState(S initialState) : _state = initialState;

  S _state;

  S getState() => _state;

  late final reducible = Reducible(getState, reduce, this);

  void reduce(Reducer<S> reducer) => setState(() => _state = reducer(_state));

  @override
  Widget build(BuildContext context) => widget.builder(
        reducible,
        widget.child,
      );
}
```

#### InheritedValueWidget

Die Klasse `InheritedValueWidget` erbt von InheritedWidget. Sie bekommt im Konstruktor einen Wert `value`, speichert ihn in einem gleichnamigen finalen Feld und stellt diesen Wert nachfolgenden Kind- und Kindeskind-Widgets über eine of-Methode zur Verfügung.

```dart
class InheritedValueWidget<V> extends InheritedWidget {
  const InheritedValueWidget({
    super.key,
    required super.child,
    required this.value,
  });

  final V value;

  static U of<U>(BuildContext context) =>
      _widgetOf<InheritedValueWidget<U>>(context).value;

  static W _widgetOf<W extends InheritedValueWidget>(
          BuildContext context) {
              final result = context.dependOnInheritedWidgetOfExactType<W>();
              if(result == null) {
                throw AssertionError('InheritedValueWidget._widgetOf<$W> return null');
              }
              return result;
            }

  @override
  bool updateShouldNotify(InheritedValueWidget oldWidget) =>
      value != oldWidget.value;
}
```

### MyAppStateBinder 

Die Klasse `MyAppStateBinder` kapselt in der hier vorgestellten Code-Struktur die App-Zustands-Verwaltung, bei der es sich entweder um ein Framework, wie Riverpod oder Bloc, oder um eine eigene Implementierung handeln kann. 
Als Beispiel implementieren wir Die Klasse `MyAppStateBinder` mit Hilfe von `AppStateBinder` und `InheritedValueWidget` selbst.

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => ReducibleStatefulWidget(
        initialState: const MyAppState(title: 'setState'),
        child: child,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePagePropsConverter.convert(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetPropsConverter.convert(value),
            child: child,
          ),
        ),
      );
}
```

Das `MyAppStateBinder`-Widget bildet die Wurzel der Widget-Hierarchie der App und ist für die Bindung der App-Zustands-Verwaltung an die UI verantwortlich. Es stellt der nachfolgenden Widget-Hierarchie den Zugang zur App-Zustands-Verwaltung in Form des Interfaces `Reducible` bereit. 
</br>
In diesem Fall haben wir die App-Zustands-Verwaltung einer Kombination aus StatefulWidget und InheritedWidget selbst implementiert und stellen das Interface `Reducible`, wie bei InheritedWidgets üblich, mit einer statischen Methode `T of<T>(BuildContext context)` bereit.

### main

In der main-Funktion werden Instanzen der Klassen `MyAppStateBinder` für die App-Zustands-Verwaltung und `MyAppBuilder` für die UI erzeugt, miteinander verknüpft und die App gestartet.

```dart
void main() {
  runApp(const MyAppStateBinder(child: MyAppBuilder()));
}
```

## Zugabe

Mit der main-Funktion könnte das Beispiel und dieser Artikel enden. Doch es gibt noch eine Verlängerung, und auf die könnte der Titel des Films "Das Beste kommt zum Schluss" passen:

1. **Skalierbarkeit**</br> Um zu zeigen, dass die neue Code-Struktur einfach skalierbar ist, extrahieren wir aus der Klasse `MyHomePageBuilder` eine Klasse `MyCounterBuilder`, die nur die Anzeige des Zählerwerts enthält, und implementieren für beide Klassen individuelle selektive Bindungen an den App-Zustand, so dass die build-Methoden von `MyHomePageBuilder` und `MyCounterBuilder` nur ausgeführt werden, wenn sich ihre Props tatsächlich ändern.

2. **Testbarkeit**</br> Um zu zeigen, wie die Trennung der Verantwortlichkeiten im Code für eine Vereinfachung der Tests genutzt werden kann, schreiben wir für die umgestellte Counter-Demo-App einen UI-Test und einen App-Logik-Test.

3. **Portierbarkeit**</br> Um zu zeigen, dass die neue Code-Struktur die Abhängigkeit vom verwendeten Framework tatsächlich veringert und sich auf die Binder-Klassen beschränkt, portieren wir die umgestellte Counter-Demo-App von der eigenen App-Zustands-Verwaltungs-Implementierung nacheinander auf verschieden App-Zustands-Verwaltungs-Frameworks.

### Skalierung

Beim bisher erreichten Stand der Umgestaltung der Flutter-Counter-App hat sich eines gegenüber dem Original nicht geändert: Bei jeder Änderung des App-Zustandes wird der Widget-Baum der gesamten App-Seite neu gebaut. 
</br>
Für komplexere Apps kann dies zu einem Performance-Problem werden. Darum ist es essenziell, bei Änderungen des App-Zustandes nur die Teil-Bäume der App-Seite neu zu bauen, die tatsächlich von der Änderung betroffen sind. 
</br>
Im Widget-Baum der Flutter-Counter-App-Seite ist die AppBar vom Property `title` abhängig, der FloatingActionButton vom Property `onIncrementPressed` und ein Text-Widget vom Property `counterText`.
</br>
Wir wollen nun die App so refaktorisieren, dass bei Änderungen des Properties `counterText` nur noch das betroffene Text-Widget neu erzeugt wird und die anderen Widgets des Widget-Baums der App-Seite weiter 
genutzt werden. Der Umbau erfolgt in 5 Schritten:

1\. **Props**</br>
Dazu extrahieren wir aus der Klasse `MyHomePageProps` das Property `counterText` in eine neue Klasse `MyCounterWidgetProps` und definieren den benannten Konstruktor `MyCounterWidgetProps.reducible`.

```dart
class MyHomePageProps {
  final String title;
  final Callable onIncrementPressed;

  const MyHomePageProps({
    required this.title,
    required this.onIncrementPressed,
  });

  @override
  int get hashCode => Object.hash(title, onIncrementPressed);

  @override
  bool operator ==(Object other) =>
      other is MyHomePageProps &&
      title == other.title &&
      onIncrementPressed == other.onIncrementPressed;

  @override
  String toString() => 'MyHomePageProps#$hashCode';
}
```

```dart
class MyCounterWidgetProps {
  final String counterText;

  const MyCounterWidgetProps({
    required this.counterText,
  });

  @override
  int get hashCode => counterText.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyCounterWidgetProps && counterText == other.counterText;

  @override
  String toString() =>
      'MyCounterWidgetProps#$hashCode(counterText=$counterText)';
}
```

2\. **Änderungs-Selektor**</br>
In der Klasse `MyAppStateBinder` fügen wir ein `InheritedValueWidget` mit einem Template-Parameter vom Typ `MyCounterWidgetProps` ein.

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final MyAppState state = const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  final Widget child;

  @override
  Widget build(context) => AppStateBinder(
        initialState: state,
        child: child,
        builder: (value, child) => InheritedValueWidget(
          value: MyHomePageProps.reducible(value),
          child: InheritedValueWidget(
            value: MyCounterWidgetProps.reducible(value),
            child: child,
          ),
        ),
      );
}
```

3\. **Builder**</br>
Aus der build-Methode der Klasse `MyHomePageBuilder` extrahieren wir das relevante Text-Widget in eine neue Klasse `MyCounterWidgetBuilder` und verwenden die Klasse `MyCounterWidgetProps` als Konstruktor-Parameter.

```dart
class MyCounterWidgetBuilder extends StatelessWidget {
  const MyCounterWidgetBuilder({super.key, required this.props});

  final MyCounterWidgetProps props;

  @override
  Widget build(context) => Text(
        props.counterText,
        style: Theme.of(context).textTheme.headlineMedium,
      );
}
```

4\. **Binder**</br>
Nach dem Muster von `MyHomePageBinder` erzeugen wir eine neue Klasse `MyCounterWidgetBinder` und holen ins in deren build-Methode vom `InheritedValueWidget` die `MyCounterWidgetProps` und bauen damit den `MyCounterWidgetBuilder`.

```dart
class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => MyCounterWidgetBuilder(
        props: InheritedValueWidget.of<MyCounterWidgetProps>(context),
      );
}
```

5\. **Scharfschaltung**</br> 
Schließlich ersetzen wir in build-Methode der Klasse `MyHomePageBuilder` das Text-Widget durch `MyCounterWidgetBuilder`.

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
            children:  const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              MyCounterWidgetBinder(),
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

Damit ist die Einführung und Nutzung einer neuen Builder-Binder-Props-Klassen-Kombination abgeschlossen und kann genutzt werden. 

### Test

Die App ist sauber nach UI-Code und App-Logik-Code getrennt. Diese Trennung wollen wir nun auch in den Tests vornehmen.

#### App-Logik-Tests

In der hier vorgestellten Code-Struktur befindet sich die App-Logik in den call-Methoden der Reducer-Klassen und in den `convert`-Funktionen zur Erzeugunf der  Props-Instanzen. In unserem Beispiel-Projekt ist das die Klasse `IncrementCounterReducer` und die Funkrionen `MyHomePagePropsConverter.convert` und `MyCounterWidgetPropsConverter.convert`. Da diese Klassen und Funktionen keine UI-Ablaufumgebung benötigen, können sie mit einfachen Unit-Tests getestet werden.

Hier ein Beispiel-Test für die call-Methode der Klasse `IncrementCounterReducer`:

```dart
  test('testIncrementCounterReducer', () {
    final objectUnderTest = IncrementCounterReducer();
    final state = objectUnderTest.call(
      const MyAppState(title: 'mock', counter: 0),
    );
    expect(state.counter, equals(1));
  });
```

Hier ein Beispiel-Test für die Methode `convert` der Klasse `MyCounterWidgetPropsConverter`:

```dart
  test('testMyCounterWidgetProps', () {
    Reducible<MyAppState> reducible = Reducible(
      () => const MyAppState(title: 'mock', counter: 0),
      (_) {},
      false,
    );
    final objectUnderTest =
        MyCounterWidgetPropsConverter.convert(reducible);
    expect(objectUnderTest.counterText, equals('0'));
  });
```

Hier ein Beispiel-Test für die Methode `convert` der Klasse `MyHomePagePropsConverter`:

```dart
  test('testMyHomePageProps', () {
    const title = 'mock';
    final incrementReducer = IncrementCounterReducer();
    final decrementReducer = DecrementCounterReducer();
    final reducible = Reducible(
      () => const MyAppState(counter: 0, title: title),
      (_) {},
      false,
    );
    final onIncrementPressed =
        BondedReducer(reducible, incrementReducer);
    final onDecrementPressed =
        BondedReducer(reducible, decrementReducer);
    final objectUnderTest = MyHomePagePropsConverter.convert(reducible);
    final expected = MyHomePageProps(
      title: title,
      onIncrementPressed: onIncrementPressed,
    );
    final withUnexpectedTitle = MyHomePageProps(
      title: '_$title',
      onIncrementPressed: onIncrementPressed,
    );
    final withUnexpectedCallback = MyHomePageProps(
      title: title,
      onIncrementPressed: onDecrementPressed,
    );
    expect(objectUnderTest, equals(expected));
    expect(objectUnderTest, isNot(equals(withUnexpectedTitle)));
    expect(objectUnderTest, isNot(equals(withUnexpectedCallback)));
  });
```

Um die Methoden `operator==` der Props-Klassen genau testen zu können (notwendig für selektive Änderungsbenachrichtigungen), wurde für den Test `testMyHomePageProps` eine weitere Reducer-Klasse `DecrementCounterReducer` angelegt. 

```dart
class DecrementCounterReducer extends Reducer<MyAppState> {
  DecrementCounterReducer._();
  factory DecrementCounterReducer() => instance;

  static final instance = DecrementCounterReducer._();

  @override
  MyAppState call(state) =>
      state.copyWith(counter: state.counter - 1);
}
```

#### UI-Tests

Ensprechend der Code-Struktur können wir die Tests in Builder-Tests, Binder-Tests und Tests der kompletten App einteilen:

##### Builder-Tests

Die Builder-Klassen haben die Verantwortlichkeiten Layout, Rendering und Gestenerkennung und dies sollte sich in den Builder-Tests wiederfinden. Es kann einen gewissen Aufwand verursachen, eine App in den jeweiligen Zustand zu bringen, in welchem Layout, Rendering oder Gestenerkennung getestet werden sollen. Wenn für eine hohe Testabdeckung viele Zustände benötigt werden, ist jede Erleichterung wünschenswert. Mit der hier vorgestellten Code-Struktur ist eine Erleichterung für das Einstellen von Zuständen möglich:
</b>
Dazu erstellen wir zunächst einige Utility-Klassen:

```dart
class MyMockProps {
  final MyHomePageProps myHomePageProps;
  final MyCounterWidgetProps counterWidgetProps;

  MyMockProps({
    required String title,
    required Callable<void> onIncrementPressed,
    required String counterText,
  })  : myHomePageProps = MyHomePageProps(
          title: title,
          onIncrementPressed: onIncrementPressed,
        ),
        counterWidgetProps = MyCounterWidgetProps(
          counterText: counterText,
        );
}
```

```dart
extension MockPropsOnBuildContext on BuildContext {
  MyMockProps get mock => InheritedValueWidget.of<MyMockProps>(this);
}
```

```dart
class MyMockPropsBinder extends StatelessWidget {
  const MyMockPropsBinder({
    super.key,
    required this.child,
    required this.props,
  });

  final Widget child;
  final MyMockProps props;

  @override
  Widget build(context) => InheritedValueWidget(
        value: props,
        child: child,
      );
}
```

```dart
class MockCallable extends Callable<void> {
  int count = 0;
  
  @override
  void call() => ++count;
}
```

Mit den Utility-Klassen erstellen wir Mock-Builder-Klassen, mit denen man die Props für die Builder-Klassen vorgeben kann:

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => child;
}
```

```dart
class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) => MyHomePageBuilder(
        props: context.mock.myHomePageProps,
      );
}
```

```dart
class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) => MyCounterWidgetBuilder(
        props: context.mock.counterWidgetProps,
      );
}
```

Nach diesen Vorbereitungen können wir mit dem MyMockProps-Konstruktor nun einfach Builder-Tests für jeden Zustand gewünschten implementieren. Für die überschaubaren Zustände unserer Beispiel-App mag der Vorbereitungsaufwand übertrieben sein,
bei größeren Apps kann er sich lohnen. 
</br>
Hier nun ein Builder-Test:

```dart
  testWidgets('testBuilder', (tester) async {
    const title = 'title';
    const counterText = '0';
    final onIncrementPressed = MockCallable();
    final app = MyMockPropsBinder(
      props: MyMockProps(
        title: title,
        counterText: '0',
        onIncrementPressed: onIncrementPressed,
      ),
      child: const MyAppBuilder(),
    );
    await tester.pumpWidget(app);
    expect(find.widgetWithText(AppBar, title), findsOneWidget);
    expect(
      find.widgetWithText(MyCounterWidgetBuilder, counterText),
      findsOneWidget,
    );
    await tester.tap(find.byIcon(Icons.add));
    expect(onIncrementPressed.count, equals(1));
  });
```

##### Binder-Tests

Die Binder-Klassen müssen bei relevanten App-Zustands-Änderungen (und möglichst nur dann) dafür sorgen, dass ihr zugehöriges Builder-Widget mit den richtigen Props neu gebaut wird. 
</br>
Im `testSelectiveRebuild` wird geprüft, dass beim Drücken des Plus-Button das MyCounterWidgetBuilder-Widget neu gebaut wird, aber das MyHomePageBuilder-Widget nicht.

```dart
  testWidgets('selective rebuild test',
      (WidgetTester tester) async {

    const app = MyAppBuilder();
    const binder = MyAppStateBinder(child: app);
    await tester.pumpWidget(binder);

    final homePage0 = find.singleWidgetByType(MyHomePageBuilder);
    final counterWidget0 =
        find.singleWidgetByType(MyCounterWidgetBuilder);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    final homePage1 = find.singleWidgetByType(MyHomePageBuilder);
    final counterWidget1 =
        find.singleWidgetByType(MyCounterWidgetBuilder);

    expect(identical(homePage0, homePage1), isTrue);
    expect(identical(counterWidget0, counterWidget1), isFalse);
  });
```

```dart
extension SingleWidgetByType on CommonFinders {
  T singleWidgetByType<T>(Type type) =>
      find.byType(type).evaluate().single.widget as T;
}
```

### Portierung auf Riverpod

Zum Abschluss des Tutorials soll die App von der selbstgebauten App-Zustands-Verwaltung nacheinander auf die bekannten App-Zustands-Verwaltungs-Frameworks Riverpod und Bloc portiert werden. Wir beginnen mit der Portierung auf Riverpod.

Dazu legen wir im Ordner `examples/lib/approaches` einen Unterordner `riverpod` an und darin die Dateien `riverpod_reducible.dart`, `riverpod_adapter.dart` und `riverpod_binder.dart`.

In der Datei `riverpod_reducible.dart` definieren wir die Klasse `MyAppStateNotifier` und die finale Variable `appStateProvider` für den App-Zustand.

```dart
class MyAppStateNotifier extends StateNotifier<MyAppState> {
  MyAppStateNotifier()
      : super(const MyAppState(
          title: 'Flutter Demo Home Page',
          counter: 0,
        ));

  late final reducible = Reducible(getState, reduce);

  MyAppState getState() => super.state;

  void reduce(Reducer<MyAppState> reducer) => state = reducer(state);
}
```

```dart
final appStateProvider =
    StateNotifierProvider<MyAppStateNotifier, MyAppState>(
  (ref) => MyAppStateNotifier(),
);
```

In der Datei `riverpod_binder.dart` definieren wir die finalen Variablen `homePagePropsProvider` und `counterWidgetPropsProvider` zur Bereitstellung der Props.

```dart
final counterWidgetPropsProvider = StateProvider(
  (ref) {
    final appStateNotifier = ref.watch(appStateProvider.notifier);
    return ref.watch(
      appStateProvider.select(
        (state) => MyCounterWidgetProps.reducible(
          appStateNotifier.reducible,
        ),
      ),
    );
  },
);
```

```dart
final homePagePropsProvider = StateProvider(
  (ref) {
    final appStateNotifier = ref.watch(appStateProvider.notifier);
    return ref.watch(
      appStateProvider.select(
        (state) => MyHomePageProps.reducible(
          appStateNotifier.reducible,
        ),
      ),
    );
  },
);
```

In der Datei `riverpod_binder.dart` duplizieren wir alle Klassen aus `setstate_binder.dart` und stellen sie auf Riverpod um.

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final MyAppBuilder child;

  @override
  Widget build(context) => ProviderScope(child: child);
}
```

```dart
class MyHomePageBinder extends ConsumerWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context, ref) => MyHomePageBuilder(
        props: ref.watch(homePagePropsProvider),
      );
}
```

```dart
class MyCounterWidgetBinder extends ConsumerWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context, ref) => MyCounterWidgetBuilder(
        props: ref.watch(counterWidgetPropsProvider),
      );
}
```

Nun können wir in der Datei `examples/lib/view/binder.dart` den Schalter umlegen und anstelle von `examples/lib/approaches/setstate/setstate_binder.dart` die Datei `examples/lib/approaches/riverpod/riverpod_binder.dart` exportieren. Damit ist die Portierung auf Riverpod abgeschlossen und die App kann verwendet werden.

### Portierung auf Bloc

Den Abschluss des Tutorials bildet die Portierung auf Bloc.
Dazu legen wir im Ordner `examples/lib/approaches` einen Unterordner `bloc` an und darin die Dateien `bloc_reducible.dart`, `blc_adapter.dart` und `bloc_binder.dart`.

In der Datei `bloc_reducible.dart` definieren wir die Klasse `MyAppStateBloc`
und eine BuildContext-Extension für den bequemen Zugriff auf die Instanz dieser Klasse.

```dart
class MyAppStateBloc extends Bloc<Reducer<MyAppState>, MyAppState> {
  MyAppStateBloc()
      : super(
          const MyAppState(
            title: 'Flutter Demo Home Page',
            counter: 0,
          ),
        ) {
    on<Reducer<MyAppState>>((event, emit) => emit(event(state)));
  }

  MyAppState getState() => state;

  late final reducible = Reducible(getState, add);
}
```

```dart
extension MyAppStateBlocOnBuildContext on BuildContext {
  MyAppStateBloc get appStateBloc =>
      BlocProvider.of<MyAppStateBloc>(this);
}
```

In der Datei `bloc_binder.dart` duplizieren wir alle Klassen aus `stateful_binder.dart` (oder `riverpod_binder.dart`) und stellen sie auf Bloc um.

```dart
class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final MyAppState state = const MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  final Widget child;

  @override
  Widget build(context) => BlocProvider(
        create: (_) => MyAppStateBloc(),
        child: child,
      );
}
```

```dart
class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) =>
      BlocSelector<MyAppStateBloc, MyAppState, MyHomePageProps>(
        selector: (state) => MyHomePageProps.reducible(
          context.appStateBloc.reducible,
        ),
        builder: (context, props) => MyHomePageBuilder(
          props: props,
        ),
      );
}
```

```dart
class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) =>
      BlocSelector<MyAppStateBloc, MyAppState, MyCounterWidgetProps>(
        selector: (state) => MyCounterWidgetProps.reducible(
          context.appStateBloc.reducible,
        ),
        builder: (context, props) => MyCounterWidgetBuilder(
          props: props,
        ),
      );
}
```

Nun können wir in der Klasse `examples/view/binder.dart`den Schalter umlegen und anstelle von `stateful_binder.dart` oder `riverpod_binder.dart` die Datei `bloc_binder.dart` exportieren. Damit ist die Portierung nach Bloc abgeschlossen und die App kann verwendet werden.

### Portierung auf weitere App-Zustands-Verwaltungs-Frameworks

Unter [examples/lib/approaches/](https://github.com/partmaster/reducible/tree/main/examples/lib/approaches) liegen neben den Portierungen auf Riverpod und Bloc  Portierungen auf weitere App-Zustands-Verwaltungs-Frameworks. Hier die komplette Liste der App-Zustands-Verwaltungs-Frameworks, auf die die Reducible Abstraktion portiert wurde:

|Name|Publisher|Popularity|Published|
|---|---|---|---|
|[Binder](https://pub.dev/packages/binder)|[romainrastel.com](https://pub.dev/publishers/romainrastel.com)|75%|Mar 2021|
|[Flutter Bloc](https://pub.dev/packages/flutter_bloc)|[bloclibrary.dev](https://pub.dev/publishers/bloclibrary.dev)|100%|Feb 2023|
|[Flutter Command](https://pub.dev/packages/flutter_command)|[escamoteur](https://github.com/escamoteur)|/3%|May 2021|
|[Flutter Triple](https://pub.dev/packages/flutter_triple)|[flutterando.com.br](https://pub.dev/publishers/flutterando.com.br/packages)|93%|Jul 2022|
|[GetIt](https://pub.dev/packages/get_it)|[fluttercommunity.dev](https://pub.dev/publishers/fluttercommunity.dev)|100%|Jul 2021|
|[GetX](https://pub.dev/packages/get)|[getx.site](https://pub.dev/publishers/getx.site)|100%|May 2022|
|[MobX](https://pub.dev/packages/flutter_mobx)|[dart.pixelingene.com](https://pub.dev/publishers/dart.pixelingene.com)|99%|Nov 2022|
|[Provider](https://pub.dev/packages/provider)|[dash-overflow.net](https://pub.dev/publishers/dash-overflow.net)|100%|Dec 2022|
|[Redux](https://pub.dev/packages/flutter_redux)|[brianegan.com](https://pub.dev/publishers/brianegan.com)|98%|May 2022|
|[Riverpod](https://pub.dev/packages/flutter_riverpod)|[dash-overflow.net](https://pub.dev/publishers/dash-overflow.net)|99%|Feb 2023|
|[Solidart](https://pub.dev/packages/flutter_solidart)|[bestofcode.dev](https://pub.dev/publishers/bestofcode.dev)|58%|Jan 2023|
|[States Rebuilder](https://pub.dev/packages/states_rebuilder)|[Mellati Fatah](https://github.com/GIfatahTH)|93%|Dec 2022| 

Dies sind bis auf Fish Redux [^23] alle in der offiziellen Flutter-Dokumentation gelisteten Frameworks [^6]. Eine Portierung auf Fish Redux habe ich abgewählt, weil die verfügbare Version nicht 'Null safety' [^24] ist.

## Offene Enden

### Grauzonen zwischen UI uns App-Logik

Zur Implementierung einiger UI-Aktionen benötigt man einen [BuildContext]. Ein prominentes Beispiel ist die Navigation zwischen App-Seiten mit [Navigator.of(BuildContext)]. Die Entscheidung, wann zu welcher App-Seite navigiert wird, ist App-Logik. Die App-Logik sollte möglichst ohne Abhängigkeiten von der UI-Ablaufumgebung bleiben, und ein [BuildContext] repräsentiert quasi diese Ablaufumgebung. 
</br>
Ein ähnliches Problem sind UI-Ressourcen wie Bilder, Icons, Farben und Fonts, die eine Abhängigkeit zur UI-Ablaufumgebung besitzen und deren Bereitstellung UI-App-Logik erfordern kann. 
Zwischen UI-Code und App-Logik-Code gibt es also noch Grauzonen, die in klare Abgrenzungen umgewandelt werden sollten. (Im Fall des [Navigator]s gibt es mit dem Property [MaterialApp.navigatorKey] einen möglichen Workaround für die Navigation zwischen App-Seiten ohne [BuildContext].) 
 
### Lokale App-Zustände

Der Ansatz, den kompletten App-Zustand als unveränderliche Instanz einer einzigen Klasse zu modellieren, wird bei sehr komplexen Datenstrukturen, sehr großen Datenmengen oder sehr häufigen Änderungsaktionen an seine Grenzen kommen [^15].</br>

In der Redux-Dokumentation gibt es Hinweise [^16], [^17], wie man diese Grenzen durch eine gute Strukturierung der App-Zustands-Klasse erweitern kann.</br>

Letztlich kann man versuchen, Performance-kritische Teile aus dem globalen App-Zustand zu extrahieren und mit lokalen Zustands-Verwaltungs-Lösungen umzusetzen. 
Im App-Zustands-Verwaltungs-Framework Fish-Redux [^23] ist es z.B. grundsätzlich so, dass (neben einen globalen App-Zustand) für jede App-Seite eine lokale Seiten-Zustands-Verwaltungs-Instanz existiert.  

### UI-Code-Strukturierung

In diesem Artikel wurden Code-Struktur und Entwurfsmuster für eine Trennung der Verantwortlichkeiten von UI-Code und App-Logik-Code diskutiert. 
</br>
Eine separierte App-Logik kann man mit allen verfügbaren Architektur-Ansätzen und Entwurfmustern weiterstrukturiert werden und ist für mich darum kein offenes Ende dieses Artikels über Flutter-App-Code.
</br>
Für den separierten Flutter-UI-Code werden allerdings für größere Projekte weitere interne Strukturierungskonzepte benötigt, die die Vorteile aus dem Flutter-Prinzip 'Alles ist ein Widget' nutzen. Hier einige offene Punkte:

* Wie separiere ich das Theming, z.B. Light Mode und Dark Mode?

* Wie separiere ich die Layout-Adaptionen für verschiedene Endgeräte-Gruppen, z.B. Smartphone, Tablet, Desktop ? 

* Wie separiere ich den Code für die Layout-Resposivness für Änderungen der App-Display-Größe zwischen den Adaptionsstufen ?

* Wie separiere ich den Code für Animationen?

### Groß-Projekt-Erprobung

Die in diesem Artikel vorgestellte Code-Struktur ist ein Ergebnis meiner Erfahrungen aus kleinen und mittleren Flutter-Projekten. Eines davon ist das Projekt Cantarei - die Taizé-Lieder-App. Die App ist frei im Apple- [^19] und im Google- [^20] App-Store verfügbar, so dass jeder Interessierte selbst einen Eindruck gewinnen kann, für welche Projekt-Größen die hier vorgeschlagenen Konzepte bereits praxiserprobt sind. Ob sie sich, so wie sie sind, mit Erfolg auf größere Projekte anwenden lassen, müsste noch geprüft werden.

## Fazit

Code-Struktur und Entwurfsmuster sind wichtige Themen der App-Architektur. Mit diesem Artikel wollte ich etwas zur Diskussion darüber beitragen. 

## Referenzen

[^1]: Entwurfmuster</br> [en.wikipedia.org/wiki/Software_design_pattern](https://en.wikipedia.org/wiki/Software_design_pattern)

[^2]: Trennung der Verantwortlichkeiten</br> [en.wikipedia.org/wiki/Separation_of_concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)

[^3]: Flutter</br> [flutter.dev](https://flutter.dev/)

[^4]: Riverpod</br> [riverpod.dev](https://riverpod.dev/)

[^5]: Bloc</br> [bloclibrary.dev](https://bloclibrary.dev/)

[^6]: Flutter State Management Approaches</br> [docs.flutter.dev/development/data-and-backend/state-mgmt/options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)

[^7]: Humble Object Pattern</br> [xunitpatterns.com/Humble Object.html](http://xunitpatterns.com/Humble%20Object.html)

[^8]: Reducer Pattern</br> [redux.js.org/tutorials/fundamentals/part-3-state-actions-reducers](https://redux.js.org/tutorials/fundamentals/part-3-state-actions-reducers)

[^9]: Alles ist ein Widget</br> [docs.flutter.dev/development/ui/layout](https://docs.flutter.dev/development/ui/layout)

[^10]: Redux</br> [redux.js.org/](https://redux.js.org/)

[^11]: Pure Funktion</br> [en.wikipedia.org/wiki/Pure_function](https://en.wikipedia.org/wiki/Pure_function)

[^12]: Wertsemantik</br> [en.wikipedia.org/wiki/Value_semantics](https://en.wikipedia.org/wiki/Value_semantics)

[^13]: Michael Feathers [michaelfeathers.silvrback.com/bio](https://michaelfeathers.silvrback.com/bio)

[^14]: Faltungsfunktion</br> [www.cs.nott.ac.uk/~gmh/fold.pdf](http://www.cs.nott.ac.uk/~gmh/fold.pdf)

[^15]: Reducer Pattern Nachteil</br> [twitter.com/acdlite/status/1025408731805184000](https://twitter.com/acdlite/status/1025408731805184000)

[^16]: App-Zustands-Gliederung</br> [redux.js.org/usage/structuring-reducers/basic-reducer-structure](https://redux.js.org/usage/structuring-reducers/basic-reducer-structure)

[^17]: App-Zustands-Normalisierung</br> [redux.js.org/usage/structuring-reducers/normalizing-state-shape](https://redux.js.org/usage/structuring-reducers/normalizing-state-shape)

[^18]: React</br> [reactjs.org/](https://reactjs.org/)

[^19]: Die App *Cantarei* im Apple-Appstore [apps.apple.com/us/app/cantarei/id1624281880](https://apps.apple.com/us/app/cantarei/id1624281880)

[^20]: Die App *Cantarei* im Google-Playstore [play.google.com/store/apps/details?id=de.partmaster.cantarei](https://play.google.com/store/apps/details?id=de.partmaster.cantarei)

[^21]: Unnötige Abstraktionen [twitter.com/remi_rousselet/status/1604603131500941317](https://twitter.com/remi_rousselet/status/1604603131500941317)

[^22]: Proxy Pattern [en.wikipedia.org/wiki/Proxy_pattern](https://en.wikipedia.org/wiki/Proxy_pattern)

[^23]: Fish Redux [pub.dev/packages/fish_redux](https://pub.dev/packages/fish_redux)

[^24]: Null Safety [dart.dev/null-safety#enable-null-safety](https://dart.dev/null-safety#enable-null-safety)