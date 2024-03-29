## 0.1.0

* initial release.

## 0.2.0

* rename Reducible to ReducedStore
* replace function wrapWithProvider with widget class ReducedProvider
* replace function wrapWithConsumer with widget class ReducedConsumer
* replace function wrapWithScope with widget class ReducedScope

## 0.2.1

* use reduced_bloc and reduced_provider v2.0.1 from git in examples

## 0.2.2

* replace <br/> with backslash in README.md

## 0.3.1

* rename 'reduce' to 'dispatch' and 'reducer' to 'event'

## 0.3.2

* use reduced_setstate, reduced_bloc and reduced_provider v0.3.2 from git in examples

## 0.4.0

* rename 'dispatch' to 'process'
* rename 'ReducedStore' to 'Store'
* rename 'ReducedStoreProxy' to 'StoreProxy'
* rename 'CallableAdapter' to 'EventCarrier'
* rename 'EventAdapter' to 'ParameterizedEvent'
* rename 'ReducedWidgetBuilder' to 'WidgetFromPropsBuilder'
* rename 'ReducedTransformer' to 'StateToPropsMapper'
* extract 'process' method to its own interface 'EventProcessor'
* add 'EventListener'
* use two parameters 'state' and 'processor' instead of one 'store' parameter

## 0.4.1

* split parametrized.dart from event.dart
* split carrier.dart from callable.dart
* split proxy.dart from store.dart

## 0.5.0

* rename EventCarrier to Action
* rename carrier.dart to action.dart
* rename functions.dart to function.dart
* add FutureCreator, FutureCreator1
* add StreamCreator, StreamCreator1
* add FutureAction, FutureAction1
* add StreamAction, StreamAction1
* split parameter store of EventListener into state and processor

## 0.6.0

* rename Action to Command
* rename action.dart to command.dart
* rename FutureAction to FutureCommand
* rename StreamCommand to StreamCommand
* add hashCode and operator== to command classes and event decorators
* add StoreSnapshot and CompositeCallable
* add RoutingContext