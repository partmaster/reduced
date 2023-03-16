import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/parametrized.dart';

class MockEvent1 extends Event1<String, String> {
  @override
  call(state, value) => '$state $value';
}

void main() {
  test('Parametrized1Event call test', () {
    final event = MockEvent1();
    final objectUnderTest = Parametrized1Event(event, '1');
    expect(objectUnderTest.call('0'), '0 1');
  });
  test('Parametrized1Event hashCode test', () {
    final event1 = MockEvent1();
    final event2 = MockEvent1();
    final objectUnderTest11 = Parametrized1Event(event1, '1');
    final objectUnderTest12 = Parametrized1Event(event1, '2');
    final objectUnderTest21 = Parametrized1Event(event2, '1');
    final objectUnderTest22 = Parametrized1Event(event1, '1');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Parametrized1Event operator== test', () {
    final event1 = MockEvent1();
    final event2 = MockEvent1();
    final objectUnderTest11 = Parametrized1Event(event1, '1');
    final objectUnderTest12 = Parametrized1Event(event1, '2');
    final objectUnderTest21 = Parametrized1Event(event2, '1');
    final objectUnderTest22 = Parametrized1Event(event1, '1');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
