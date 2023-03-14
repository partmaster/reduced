import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockReducer extends Event<Object> {
  MockReducer(this.newState);

  Object newState;

  @override
  call(state) => newState;
}

class MockStore extends Store<Object> {
  MockStore(this.state);

  @override
  Object state;

  @override
  process(event) => state = event(state);
}

void main() {
  test('StoreProxy init test', () {
    final store = MockStore('0');
    final objectUnderTest = StoreProxy(() => store.state, store.process, store);
    expect(objectUnderTest.state, '0');
  });
  test('StoreProxy reduce test', () {
    final store = MockStore('0');
    final reducer = MockReducer('1');
    final objectUnderTest =
        StoreProxy(() => store.state, store.process, store, null);
    objectUnderTest.process(reducer);
    expect(objectUnderTest.state, '1');
  });
  test('StoreProxy hashCode test', () {
    final store = MockStore('0');
    final objectUnderTest = StoreProxy(() => store.state, store.process, store);
    expect(objectUnderTest.hashCode, store.hashCode);
  });
  test('StoreProxy operator== test', () {
    final store1 = MockStore('1');
    final objectUnderTest1 =
        StoreProxy(() => store1.state, store1.process, store1);
    final objectUnderTest3 =
        StoreProxy(() => store1.state, store1.process, store1);
    final store2 = MockStore('2');
    final objectUnderTest2 =
        StoreProxy(() => store2.state, store2.process, store2);
    expect(objectUnderTest1, objectUnderTest3);
    expect(objectUnderTest1, isNot(objectUnderTest2));
    expect(objectUnderTest2, isNot(objectUnderTest3));
  });
}
