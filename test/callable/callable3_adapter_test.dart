import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/reducer.dart';
import 'package:reduced/src/store.dart';

class MockReducer3 extends Reducer3<String, String, String, String> {
  MockReducer3();

  @override
  call(state, value1, value2, value3) =>
      '$state $value1 $value2 $value3';
}

class MockReducedStore extends ReducedStore<String> {
  MockReducedStore(this.state);

  @override
  String state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('Callable3Adapter init test', () {
    final objectUnterTest = Callable3Adapter(
      MockReducedStore('0'),
      MockReducer3(),
    );
    expect(objectUnterTest.store.state, '0');
  });

  test('Callable3Adapter call test', () {
    final objectUnterTest = Callable3Adapter(
      MockReducedStore('0'),
      MockReducer3(),
    );
    objectUnterTest.call('1', '2', '3');
    expect(objectUnterTest.store.state, '0 1 2 3');
  });

  test('Callable3Adapter hashCode test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer3();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer3();
    final objectUnterTest11 = Callable3Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable3Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable3Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable3Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode,
        isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode,
        isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode,
        isNot(objectUnterTest21.hashCode));
  });
  test('Callable3Adapter operator== test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer3();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer3();
    final objectUnterTest11 = Callable3Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable3Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable3Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable3Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
