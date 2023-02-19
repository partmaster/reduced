// reducer.dart

import 'package:reduced/reduced.dart';

import '../data/state.dart';

class IncrementCounterReducer extends Reducer<MyAppState> {
  IncrementCounterReducer._();
  factory IncrementCounterReducer() => instance;

  static final instance = IncrementCounterReducer._();

  @override
  MyAppState call(state) => state.copyWith(counter: state.counter + 1);
}
