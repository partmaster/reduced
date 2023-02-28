import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/callable.dart';
import 'package:reduced/reducible.dart';

class MockReducer extends Reducer<Object> {
  MockReducer(this.newState);

  Object newState;

  @override
  call(state) => newState;
}

class MockReducible extends Reducible<Object> {
  MockReducible(this.state);

  @override
  Object state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('ReducerOnReducible init test', () {
    final objectUnterTest = ReducerOnReducible(
      MockReducible(0),
      MockReducer(1),
    );
    expect(objectUnterTest.reducible.state, 0);
  });

  test('ReducerOnReducible call test', () {
    final objectUnterTest = ReducerOnReducible(
      MockReducible(0),
      MockReducer(1),
    );
    objectUnterTest.call();
    expect(objectUnterTest.reducible.state, 1);
  });

  test('ReducerOnReducible hashCode test', () {
    final reducible1 = MockReducible(1);
    final reducer1 = MockReducer(1);
    final reducible2 = MockReducible(2);
    final reducer2 = MockReducer(2);
    final objectUnterTest11 = ReducerOnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = ReducerOnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = ReducerOnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = ReducerOnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('ReducerOnReducible operator== test', () {
    final reducible1 = MockReducible(1);
    final reducer1 = MockReducer(1);
    final reducible2 = MockReducible(2);
    final reducer2 = MockReducer(2);
    final objectUnterTest11 = ReducerOnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = ReducerOnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = ReducerOnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = ReducerOnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
