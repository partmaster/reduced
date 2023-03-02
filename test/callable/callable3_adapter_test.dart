import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/reducible.dart';

class MockReducer3 extends Reducer3<String, String, String, String> {
  MockReducer3();

  @override
  call(state, value1, value2, value3) => '$state $value1 $value2 $value3';
}

class MockReducible extends Reducible<String> {
  MockReducible(this.state);

  @override
  String state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('Callable3Adapter init test', () {
    final objectUnterTest = Callable3Adapter(
      MockReducible('0'),
      MockReducer3(),
    );
    expect(objectUnterTest.reducible.state, '0');
  });

  test('Callable3Adapter call test', () {
    final objectUnterTest = Callable3Adapter(
      MockReducible('0'),
      MockReducer3(),
    );
    objectUnterTest.call('1', '2', '3');
    expect(objectUnterTest.reducible.state, '0 1 2 3');
  });

  test('Callable3Adapter hashCode test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer3();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer3();
    final objectUnterTest11 = Callable3Adapter(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Callable3Adapter(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Callable3Adapter(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Callable3Adapter(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Callable3Adapter operator== test', () {
    final reducible1 = MockReducible('1');
    final reducer1 = MockReducer3();
    final reducible2 = MockReducible('2');
    final reducer2 = MockReducer3();
    final objectUnterTest11 = Callable3Adapter(
      reducible1,
      reducer1,
    );
    final objectUnterTest12 = Callable3Adapter(
      reducible1,
      reducer2,
    );
    final objectUnterTest21 = Callable3Adapter(
      reducible2,
      reducer1,
    );
    final objectUnterTest22 = Callable3Adapter(
      reducible1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
