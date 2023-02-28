import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/callable.dart';
import 'package:reduced/reducible.dart';

class MockReducer2 extends Reducer2<String, String, String> {
  MockReducer2();

  @override
  call(state, value1, value2) => '$state $value1 $value2';
}

class MockReducible extends Reducible<String> {
  MockReducible(this.state);

  @override
  String state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('Reducer2OnReducible init test', () {
    final objectUnterTest = Reducer2OnReducible(
      MockReducible('0'),
      MockReducer2(),
    );
    expect(objectUnterTest.reducible.state, '0');
  });

  test('Reducer2OnReducible call test', () {
    final objectUnterTest = Reducer2OnReducible(
      MockReducible('0'),
      MockReducer2(),
    );
    objectUnterTest.call('1', '2');
    expect(objectUnterTest.reducible.state, '0 1 2');
  });

  test('Reducer2OnReducible hashCode test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer2();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer2();
    final objectUnterTest11 = Reducer2OnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Reducer2OnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Reducer2OnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Reducer2OnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Reducer2OnReducible operator== test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer2();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer2();
    final objectUnterTest11 = Reducer2OnReducible(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Reducer2OnReducible(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Reducer2OnReducible(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Reducer2OnReducible(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
