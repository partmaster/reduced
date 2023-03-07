import 'package:flutter_test/flutter_test.dart';
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
  test('ReducedStoreProxy init test', () {
    final store = MockReducedStore('0');
    final objectUnderTest =
        ReducedStoreProxy(() => store.state, store.reduce, store);
    expect(objectUnderTest.state, '0');
  });
  test('ReducedStoreProxy reduce test', () {
    final store = MockReducedStore('0');
    final reducer = MockReducer('1');
    final objectUnderTest =
        ReducedStoreProxy(() => store.state, store.reduce, store);
    objectUnderTest.reduce(reducer);
    expect(objectUnderTest.state, '1');
  });
  test('ReducedStoreProxy hashCode test', () {
    final store = MockReducedStore('0');
    final objectUnderTest =
        ReducedStoreProxy(() => store.state, store.reduce, store);
    expect(objectUnderTest.hashCode, store.hashCode);
  });
  test('ReducedStoreProxy operator== test', () {
    final store1 = MockReducedStore('1');
    final objectUnderTest1 =
        ReducedStoreProxy(() => store1.state, store1.reduce, store1);
    final objectUnderTest3 =
        ReducedStoreProxy(() => store1.state, store1.reduce, store1);
    final store2 = MockReducedStore('2');
    final objectUnderTest2 =
        ReducedStoreProxy(() => store2.state, store2.reduce, store2);
    expect(objectUnderTest1, objectUnderTest3);
    expect(objectUnderTest1, isNot(objectUnderTest2));
    expect(objectUnderTest2, isNot(objectUnderTest3));
  });
}
