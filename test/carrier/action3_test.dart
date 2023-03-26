import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/action.dart';
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
  test('Action3 call test', () {
    final store = MockStore('0');
    final objectUnterTest = Action3(
      store,
      MockEvent3(),
    );
    objectUnterTest.call('1', '2', '3');
    expect(store.state, '0 1 2 3');
  });

  test('Action3 hashCode test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent3();
    final store2 = MockStore('2');
    final reducer2 = MockEvent3();
    final objectUnterTest11 = Action3(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Action3(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Action3(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Action3(
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
  test('Action3 operator== test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent3();
    final store2 = MockStore('2');
    final reducer2 = MockEvent3();
    final objectUnterTest11 = Action3(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Action3(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Action3(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Action3(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
