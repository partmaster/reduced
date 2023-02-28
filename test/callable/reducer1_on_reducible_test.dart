import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/callable.dart';
import 'package:reduced/reducible.dart';

class MockReducer1 extends Reducer1<String, String> {
  MockReducer1();

  @override
  call(state, value) => '$state $value';
}

class MockReducible extends Reducible<String> {
  MockReducible(this.state);

  @override
  String state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('Reducer1OnReducible init test', () {
    final objectUnterTest = Reducer1OnReducible(
      MockReducible('0'),
      MockReducer1(),
    );
    expect(objectUnterTest.reducible.state, '0');
  });

  test('Reducer1OnReducible call test', () {
    final objectUnterTest = Reducer1OnReducible(
      MockReducible('0'),
      MockReducer1(),
    );
    objectUnterTest.call('1');
    expect(objectUnterTest.reducible.state, '0 1');
  });

  test('Reducer1OnReducible hashCode test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer1();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer1();
    final objectUnterTest11 = Reducer1OnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Reducer1OnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Reducer1OnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Reducer1OnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Reducer1OnReducible operator== test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer1();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer1();
    final objectUnterTest11 = Reducer1OnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Reducer1OnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Reducer1OnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Reducer1OnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
