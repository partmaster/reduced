import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/command.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/store.dart';

class MockEvent2 extends Event2<String, String, String> {
  MockEvent2();

  @override
  call(state, value1, value2) => '$state $value1 $value2';
}

class MockStore extends Store<String> {
  MockStore(this.state);

  @override
  String state;

  @override
  process(event) => state = event(state);
}

void main() {
  test('Action2 call test', () {
    final store = MockStore('0');
    final objectUnterTest = Command2(
      store,
      MockEvent2(),
    );
    objectUnterTest.call('1', '2');
    expect(store.state, '0 1 2');
  });

  test('Action2 hashCode test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent2();
    final store2 = MockStore('2');
    final reducer2 = MockEvent2();
    final objectUnterTest11 = Command2(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Command2(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Command2(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Command2(
      store1,
      reducer1,
    );
    expect(objectUnterTest11.hashCode, objectUnterTest22.hashCode);
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest12.hashCode));
    expect(objectUnterTest11.hashCode, isNot(objectUnterTest21.hashCode));
    expect(objectUnterTest12.hashCode, isNot(objectUnterTest21.hashCode));
  });
  test('Action2 operator== test', () {
    final store1 = MockStore('1');
    final reducer1 = MockEvent2();
    final store2 = MockStore('2');
    final reducer2 = MockEvent2();
    final objectUnterTest11 = Command2(
      store1,
      reducer1,
    );
    final objectUnterTest12 = Command2(
      store1,
      reducer2,
    );
    final objectUnterTest21 = Command2(
      store2,
      reducer1,
    );
    final objectUnterTest22 = Command2(
      store1,
      reducer1,
    );
    expect(objectUnterTest11 == objectUnterTest22, true);
    expect(objectUnterTest11 == objectUnterTest12, false);
    expect(objectUnterTest11 == objectUnterTest21, false);
    expect(objectUnterTest12 == objectUnterTest21, false);
  });
}
