import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/reducer.dart';
import 'package:reduced/src/store.dart';

class MockReducer2 extends Reducer2<String, String, String> {
  MockReducer2();

  @override
  call(state, value1, value2) => '$state $value1 $value2';
}

class MockReducedStore extends ReducedStore<String> {
  MockReducedStore(this.state);

  @override
  String state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('Callable2Adapter init test', () {
    final objectUnterTest = Callable2Adapter(
      MockReducedStore('0'),
      MockReducer2(),
    );
    expect(objectUnterTest.store.state, '0');
  });

  test('Callable2Adapter call test', () {
    final objectUnterTest = Callable2Adapter(
      MockReducedStore('0'),
      MockReducer2(),
    );
    objectUnterTest.call('1', '2');
    expect(objectUnterTest.store.state, '0 1 2');
  });

  test('Callable2Adapter hashCode test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer2();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer2();
    final objectUnterTest11 = Callable2Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable2Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable2Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable2Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Callable2Adapter operator== test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer2();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer2();
    final objectUnterTest11 = Callable2Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable2Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable2Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable2Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
