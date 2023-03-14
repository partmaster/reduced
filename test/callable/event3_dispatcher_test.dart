import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/callable.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockEvent3 extends Event3<String, String, String, String> {
  MockEvent3();

  @override
  call(state, value1, value2, value3) =>
      '$state $value1 $value2 $value3';
}

class MockStore extends Store<String> {
  MockStore(this.state);

  @override
  String state;

  @override
  process(event) => state = event(state);
}

void main() {
  test('Event3Dispatcher init test', () {
    final objectUnterTest = Event3Dispatcher(
      MockStore('0'),
      MockEvent3(),
    );
    expect(objectUnterTest.store.state, '0');
  });

  test('Event3Dispatcher call test', () {
    final objectUnterTest = Event3Dispatcher(
      MockStore('0'),
      MockEvent3(),
    );
    objectUnterTest.call('1', '2', '3');
    expect(objectUnterTest.store.state, '0 1 2 3');
  });

  test('Event3Dispatcher hashCode test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent3();
    final store2 = MockStore('2');
    final reducer2 = MockEvent3();
    final objectUnterTest11 = Event3Dispatcher(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Event3Dispatcher(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Event3Dispatcher(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Event3Dispatcher(
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
  test('Event3Dispatcher operator== test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent3();
    final store2 = MockStore('2');
    final reducer2 = MockEvent3();
    final objectUnterTest11 = Event3Dispatcher(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Event3Dispatcher(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Event3Dispatcher(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Event3Dispatcher(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
