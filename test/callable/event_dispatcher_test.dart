import 'package:flutter_test/flutter_test.dart' hide EventDispatcher;

import 'package:reduced/src/callable.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockEvent extends Event<Object> {
  MockEvent(this.newState);

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
  test('EventDispatcher init test', () {
    final objectUnterTest = EventDispatcher(
      MockStore(0),
      MockEvent(1),
    );
    expect(objectUnterTest.store.state, 0);
  });

  test('EventDispatcher call test', () {
    final objectUnterTest = EventDispatcher(
      MockStore(0),
      MockEvent(1),
    );
    objectUnterTest.call();
    expect(objectUnterTest.store.state, 1);
  });

  test('EventDispatcher hashCode test', () {
    final store1 = MockStore(1);
    final reducer1 = MockEvent(1);
    final store2 = MockStore(2);
    final reducer2 = MockEvent(2);
    final objectUnterTest11 = EventDispatcher(
      store1,
      reducer1,
    );
    final objectUnterTest12 = EventDispatcher(
      store1,
      reducer2,
    );
    final objectUnterTest21 = EventDispatcher(
      store2,
      reducer1,
    );
    final objectUnterTest22 = EventDispatcher(
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
  test('EventDispatcher operator== test', () {
    final store1 = MockStore(1);
    final reducer1 = MockEvent(1);
    final store2 = MockStore(2);
    final reducer2 = MockEvent(2);
    final objectUnterTest11 = EventDispatcher(
      store1,
      reducer1,
    );
    final objectUnterTest12 = EventDispatcher(
      store1,
      reducer2,
    );
    final objectUnterTest21 = EventDispatcher(
      store2,
      reducer1,
    );
    final objectUnterTest22 = EventDispatcher(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
