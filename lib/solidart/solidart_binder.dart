// solidart_binder.dart

import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:solidart/src/core/signal_selector.dart';

import '../builder.dart';
import '../domain.dart';
import '../reduceable.dart';

enum SignalId {
  myAppState,
}

extension StateSignalOnContext on BuildContext {
  Signal<MyAppState> get stateSignal =>
      get<Signal<MyAppState>>(SignalId.myAppState);
}

extension ReduceableOnAppStateSignal on Signal<MyAppState> {
  MyAppState getState() => value;

  void reduce(Reducer<MyAppState> reducer) {
    value = reducer(value);
  }

  Reduceable<MyAppState> get reduceable =>
      Reduceable(getState, reduce, this);
}

class MyAppStateBinder extends StatelessWidget {
  const MyAppStateBinder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(context) => Solid(
        signals: {
          SignalId.myAppState: () => createSignal<MyAppState>(
                const MyAppState(title: 'title', counter: 0),
              ),
        },
        child: Builder(builder: (context) => child),
      );
}

class MyHomePageBinder extends StatelessWidget {
  const MyHomePageBinder({super.key});

  @override
  Widget build(context) {
    final signal = context.stateSignal;
    final derivedSignal = SignalSelector<MyAppState, MyHomePageProps>(
      signal: signal,
      selector: (value) =>
          MyHomePageProps.reduceable(signal.reduceable),
      options: SignalOptions(comparator: (a, b) => a == b),
    );
    return SignalBuilder(
      signal: derivedSignal,
      builder: (_, __, ___) => MyHomePageBuilder(
        props: derivedSignal.value,
      ),
    );
  }
}

class MyCounterWidgetBinder extends StatelessWidget {
  const MyCounterWidgetBinder({super.key});

  @override
  Widget build(context) {
    final signal = context.stateSignal;
    final derivedSignal =
        SignalSelector<MyAppState, MyCounterWidgetProps>(
      signal: signal,
      selector: (value) =>
          MyCounterWidgetProps.reduceable(signal.reduceable),
      options: SignalOptions(comparator: (a, b) => a == b),
    );
    return SignalBuilder(
      signal: derivedSignal,
      builder: (_, __, ___) => MyCounterWidgetBuilder(
        props: derivedSignal.value,
      ),
    );
  }
}
