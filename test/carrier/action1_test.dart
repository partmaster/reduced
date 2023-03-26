import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/action.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockEvent1 extends Event1<String, String> {
  MockEvent1();

  @override
  call(state, value) => '$state $value';
}

class MockStore extends Store<String> {
  MockStore(this.state);

  @override
  String state;

  @override
  process(reducer) => state = reducer(state);
}

void main() {
  test('Action1 call test', () {
    final store = MockStore('0');
    final objectUnterTest = Action1(
      store,
      MockEvent1(),
    );
    objectUnterTest.call('1');
    expect(store.state, '0 1');
  });

  test('Action1 hashCode test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent1();
    final store2 = MockStore('2');
    final reducer2 = MockEvent1();
    final objectUnterTest11 = Action1(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Action1(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Action1(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Action1(
      store1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Action1 operator== test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent1();
    final store2 = MockStore('2');
    final reducer2 = MockEvent1();
    final objectUnterTest11 = Action1(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Action1(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Action1(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Action1(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
