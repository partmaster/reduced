import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockReducer1 extends Event1<String, String> {
  MockReducer1();

  @override
  call(state, value) => '$state $value';
}

class MockReducedStore extends ReducedStore<String> {
  MockReducedStore(this.state);

  @override
  String state;

  @override
  dispatch(reducer) => state = reducer(state);
}

void main() {
  test('Callable1Adapter init test', () {
    final objectUnterTest = Callable1Adapter(
      MockReducedStore('0'),
      MockReducer1(),
    );
    expect(objectUnterTest.store.state, '0');
  });

  test('Callable1Adapter call test', () {
    final objectUnterTest = Callable1Adapter(
      MockReducedStore('0'),
      MockReducer1(),
    );
    objectUnterTest.call('1');
    expect(objectUnterTest.store.state, '0 1');
  });

  test('Callable1Adapter hashCode test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer1();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer1();
    final objectUnterTest11 = Callable1Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable1Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable1Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable1Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Callable1Adapter operator== test', () {
    final store1 = MockReducedStore('1');
    final reducer1 = MockReducer1();
    final store2 = MockReducedStore('2');
    final reducer2 = MockReducer1();
    final objectUnterTest11 = Callable1Adapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Callable1Adapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Callable1Adapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Callable1Adapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
