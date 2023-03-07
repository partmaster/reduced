import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/reducer.dart';
import 'package:reduced/src/store.dart';

class MockReducer extends Reducer<Object> {
  MockReducer(this.newState);

  Object newState;

  @override
  call(state) => newState;
}

class MockReducedStore extends ReducedStore<Object> {
  MockReducedStore(this.state);

  @override
  Object state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('CallableAdapter init test', () {
    final objectUnterTest = CallableAdapter(
      MockReducedStore(0),
      MockReducer(1),
    );
    expect(objectUnterTest.store.state, 0);
  });

  test('CallableAdapter call test', () {
    final objectUnterTest = CallableAdapter(
      MockReducedStore(0),
      MockReducer(1),
    );
    objectUnterTest.call();
    expect(objectUnterTest.store.state, 1);
  });

  test('CallableAdapter hashCode test', () {
    final store1 = MockReducedStore(1);
    final reducer1 = MockReducer(1);
    final store2 = MockReducedStore(2);
    final reducer2 = MockReducer(2);
    final objectUnterTest11 = CallableAdapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = CallableAdapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = CallableAdapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = CallableAdapter(
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
  test('CallableAdapter operator== test', () {
    final store1 = MockReducedStore(1);
    final reducer1 = MockReducer(1);
    final store2 = MockReducedStore(2);
    final reducer2 = MockReducer(2);
    final objectUnterTest11 = CallableAdapter(
      store1,
      reducer1,
    );
    final objectUnterTest12 = CallableAdapter(
      store1,
      reducer2,
    );
    final objectUnterTest21 = CallableAdapter(
      store2,
      reducer1,
    );
    final objectUnterTest22 = CallableAdapter(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
