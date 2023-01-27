# Flutter-App Code-Struktur

Hier wird eine Code-Struktur vorgestellt, die durch die Anwendung von Entwurfsmustern [^1] die Trennung der Verantwortlichkeiten [^2] im Code von App-Projekten mit Flutter [^3] befördert. 

## Einleitung

Source Code scheint dem 2. Gesetz der Thermodynamik zu folgen und zur Aufrechterhaltung der Ordnung der ständigen Zuführung von äußerer Energie zu bedürfen. 
Flutter-App-Projekte sind da keine Ausnahme. Ein typisches Symptom sind build-Methoden mit wachsenden Widget-Konstruktor-Hierarchien, die von Fachlogik infiltriert werden. 
Viele Flutter-Frameworks wurden und werden entwickelt, um eine saubere Code-Struktur zu unterstützen. Dabei geht es  hauptsächlich um das Verwalten des Zustandes der App als Voraussetzung für eine Trennung der Verantwortlichkeiten zwischen Fachlogik und UI.  
Bei einem unreflektierten Einsatz solcher Frameworks besteht die Gefahr, dass sie neben ihrer eigentlichen Aufgabe, der Trennung der Verantwortlichkeiten, die Fachlogik und die UI infiltrieren.
Weil es so viele Frameworks gibt (in der offiziellen Flutter-Dokumentation sind aktuell 13 Frameworks gelistet [^1])  und die Entwicklung nicht abgeschlossen ist, kann dies besonders für langlebige App-Projekte zum Problem werden.
</br>
Im Folgenden wird eine Code-Struktur für Flutter-Apps vorgestellt, die solche unerwünschten Infiltrationen vermeidet und so die Qualität von Fachlogik- und UI-Code zu verbessert. Dabei geht es ausdrücklich nicht um die Einführung eines weiteren Frameworks sondern um die abgestimmte Anwendung von zwei Software-Mustern, Humble Object Pattern [^2] und State Reducer Pattern [^3], auf den Flutter-App-Code. 
</br>
Flutter beschreibt sich selbst gern mit dem Spruch "Alles ist ein Widget" [^4]. Damit ist gemeint, dass alle Features in Form von Widget-Klassen implementiert sind, die sich wie Lego-Bausteine aufeinander stecken lassen. Das ist eine großartige Eigenschaft mit einer kleinen Kehrseite: Wenn man nicht aufpasst, vermischen sich in den zusammengesteckten Widget-Bäumen schnell die Verantwortlichkeiten. 

Das sind einerseits die klassischen UI-Aufgaben: 

1. Layout, 

2. Rendering, 

3. Gestenerkennung 

und andererseits Aufgaben die sich auf den App-Zustand beziehen:

4. Benachrichtigung über App-Zustands-Änderungen,  

5. Konvertierung des App-Zustandes in Anzeige-Properties, 

6. Abbildung von Gesten auf App-Zustands-Operationen. 

Die UI-Aufgaben sind eng an eine Umgebung gebunden, in der User Interfaces ablaufen können, wohingegen die Logik in den App-Zustands-Aufgaben nicht unbedingt an eine UI-Ablaufumgebung gebunden ist.

## Builder, Binder und Props

Das erste Ziel ist, den Flutter-Code so zu strukturieren, dass im Widget-Baum die UI-Aufgaben streng von den App-Zustands-Aufgaben separiert werden.
Um das zu erreichen, wird das Humble Object Pattern von angewandt.
Die Zusammenfassung des Humble Object Pattern lautet: 

> Wenn Code nicht gut testbar ist, weil er zu eng mit seiner Umgebung verbunden ist, extrahiere die Logik in eine separate, leicht zu testende Komponente, die von ihrer Umgebung entkoppelt ist.

Auf eine Widget-Klasse bezogen heißt das: 

1. Wenn die Widget-Klasse sowohl UI-Aufgaben als auch 
App-Zustands-Aufgaben löst, dann wird diese Widget-Klasse in eine Builder-Klasse und eine Binder-Klasse geteilt. 

2. Die Binder-Klasse lässt sich über App-Zustandsänderngen benachrichtigen, konvertiert den aktuellen App-Zustand in die Properties für die Builder-Klassse, stellt für die Nutzergesten die Callback-Objekte mit den App-Zustands-Operationen zur Verfügung und liefert in der build-Methode ein Widget der Builder-Klasse zurück.

3. Die Builder-Klasse ist ein StatelessWidget. Sie bekommt von der Binder-Klasse im Konstruktor die vorkonfektionierten Properties und Callbacks und erzeugt in der build-Methode einen Widget-Baum aus Layout-, Renderer und Gestenerkennungs-Widgets.

4. Für die vorkonfektionierten Properties und Callback wird eine  Props-Klasse definiert - eine reine Datenklasse mit ausschließlich finalen Feldern und einem const Konstruktor.

## Reducer, Reduceable und Converter

Das zweite Ziel ist, den Code so zu strukturieren, dass die Fachlogik streng vom eingesetzten Zustands-Verwaltungs-Framework und von Flutter insgesamt separiert wird.
Um das zu erreichen, wird das State Reducer Pattern von angewandt. 
Die Zusammenfassung des State Reducer Pattern lautet [^5]:

> Anstatt sich auf Repository-Klassen zu verlassen, die ständig wechselnde Statuswerte enthalten, sind Reducer reine Funktionen [^6], die eine Aktion und einen vorherigen Status aufnehmen und einen neuen Status auf der Grundlage dieser Eingaben ausgeben.

Auf App-Code bezogen heißt das:

1. Für den App-Zustand wird eine AppState-Klasse definiert - eine reine Datenklasse mit ausschließlich finalen Feldern und einem const Konstruktor. Die App-Zustands-Verwaltung sellt eine get-Methode für den aktuellen App-Zustand zur Verfügung.  

2. Die App-Zustands-Verwaltung stellt eine reduce-Methode zur Verfügung, die einen Reducer als Parameter akzeptiert. Ein Reducer ist eine reine synchrone Funktion, die eine Instanz der AppState-Klasse als Parameter bekommt und eine neue Instanz der AppState-Klasse als Returnwert zurückgibt. Beim Aufruf führt die reduce-Methode den übergebenen Reducer mit dem aktellen App-Zustand als Parameter aus und speichert den Returnwert des Reducer-Aufrufs als neuen App-Zustand ab. 

3. Die App-Zustands-Verwaltung stellt eine Möglichkeit zur Verfügung, sich über Zustandsänderungen benachrichtigen zu lassen. In der minimalen Variante recht es aus, wenn als Benachrichtigung in einem Widget ein [setState](https://api.flutter.dev/flutter/widgets/State/setState.html) oder [markNeedsBuild](https://api.flutter.dev/flutter/widgets/Element/markNeedsBuild.html) ausgelöst wird. Diese Benachrichtigung sollte auch eine selektiv nur für ausgesuchte Änderungen möglich sein.  

Für die ersten beiden Anforderungen lässt sich leicht eine minimale Schnittstelle definieren:

1. eine get-Methode für den App-Zustand

2. eine reduce-Methode zum Ändern des App-Zustands 

```dart
abstract class Reducer<S> {
  S call(S state);
}

typedef Reduce<S> = void Function(Reducer<S>);

abstract class Reduceable<S> {
  S get state;
  Reduce<S> get reduce;
}
```

Die dritte Anforderung ist stark vom eingesetzten App-Zustands-Verwaltungs-Framework abhängig, insbesondere die selektive Benachrichtigung und wird später für ausgewählte Lösungen (StatefulWidget/InheritedWidget, Riverpod, Bloc) diskutiert. 

Mit Hilfe des vorgestellten Konzepts mit den Klassen AppState, Reducer, Reduceable sollte es möglich sein, die Fachlogik der App komplett vom ausgewählten Zustands-Verwaltungs-Framework zu entkoppeln. Die Fachlogik wird hauptsächlich Form von verschiedenen Reducer-Implementierungen bereitgestellt.
Hinzu kommen Konverter, die aus einem Reduceable und Reducern die verschiedenen Props-Klassen für die Builder-Widgets aus dem vorherigen Kapitel und für die selektiven Benachrichtigungen aus diesem Kapitel konstruieren können.

# Umsetzungsbeispiel

Nun soll die vorgestellte Code-Struktur an einem praktischen Beispiel illustriert werden. 

## Ausgangslage

Als Vorlage wird das wohlbekannte Flutter-Counter-App-Projekt verwendet. In diesem Projekt spielt die Klasse _MyHomePageState die zentrale Rolle:

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
Die Klasse _MyHomePageState und trägt die verschiedensten Verantwortungen. Hier einige Beispiele:

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


# Referenzen

[^1]: Flutter State Management Approaches</br> [docs.flutter.dev/development/data-and-backend/state-mgmt/options](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)

[^2]: Humble Object Pattern</br> [xunitpatterns.com/Humble Object.html](http://xunitpatterns.com/Humble%20Object.html)

[^3]: State Reducer Pattern</br> [kentcdodds.com/blog/the-state-reducer-pattern](https://kentcdodds.com/blog/the-state-reducer-pattern)

[^4]: everything is a widget [docs.flutter.dev/development/ui/layout](https://docs.flutter.dev/development/ui/layout)

[^5]: [killalldefects.com/2019/12/28/rise-of-the-reducer-pattern/](https://killalldefects.com/2019/12/28/rise-of-the-reducer-pattern/)

[^6]: [en.wikipedia.org/wiki/Pure_function](https://en.wikipedia.org/wiki/Pure_function)