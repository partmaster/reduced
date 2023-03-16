import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';
import 'package:reduced/src/parametrized.dart';

class MockEvent2 extends Event2<String, String, String> {
  @override
  call(state, value1, value2) => '$state $value1 $value2';
}

void main() {
  test('Parametrized2Event call test', () {
    final event = MockEvent2();
    final objectUnderTest = Parametrized2Event(event, '1', '2');
    expect(objectUnderTest.call('0'), '0 1 2');
  });
  test('Parametrized2Event hashCode test', () {
    final event1 = MockEvent2();
    final event2 = MockEvent2();
    final objectUnderTest11 = Parametrized2Event(event1, '1', '2');
    final objectUnderTest12 = Parametrized2Event(event1, '2', '3');
    final objectUnderTest21 = Parametrized2Event(event2, '1', '2');
    final objectUnderTest22 = Parametrized2Event(event1, '1', '2');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Parametrized2Event operator== test', () {
    final event1 = MockEvent2();
    final event2 = MockEvent2();
    final objectUnderTest11 = Parametrized2Event(event1, '1', '2');
    final objectUnderTest12 = Parametrized2Event(event1, '2', '3');
    final objectUnderTest21 = Parametrized2Event(event2, '1', '2');
    final objectUnderTest22 = Parametrized2Event(event1, '1', '2');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
