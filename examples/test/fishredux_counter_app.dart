// @dart=2.9

import 'package:examples/data/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

// Action Types
enum CounterAction { increment, decrement }

// Action Creators
class CounterActionCreator {
  static Action increment() {
    return const Action(CounterAction.increment);
  }

  static Action decrement() {
    return const Action(CounterAction.decrement);
  }
}

// Reducer
MyAppState _reducer(MyAppState state, Action action) {
  switch (action.type) {
    case CounterAction.increment:
      return state.copyWith(counter: state.counter + 1);
    case CounterAction.decrement:
      return state.copyWith(counter: state.counter - 1);
    default:
      return state;
  }
}

// View
Widget _buildView(
    MyAppState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(title: const Text('Counter')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Count:',
          ),
          Text(
            '${state.counter}',
            // ignore: deprecated_member_use
            style: Theme.of(viewService.context).textTheme.headline4,
          ),
        ],
      ),
    ),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () => dispatch(CounterActionCreator.increment()),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => dispatch(CounterActionCreator.decrement()),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
      ],
    ),
  );
}

// Page
class CounterPage extends Page<MyAppState, Map<String, dynamic>> {
  CounterPage()
      : super(
          initState: (_) => const MyAppState(title: 'fish_redux'),
          reducer: _reducer,
          view: _buildView,
        );
}

void main() {
  runApp(MaterialApp(
    title: 'Fish Redux Counter',
    home: CounterPage().buildPage({}),
  ));
}
