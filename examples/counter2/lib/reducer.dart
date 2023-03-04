// reducer.dart

import 'package:reduced/reduced.dart';

import 'state.dart';

class Incrementer extends Reducer<MyAppState> {
  @override
  call(state) => state.copyWith(counter: state.counter + 1);
}
