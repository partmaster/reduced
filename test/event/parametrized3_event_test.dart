import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';

class MockEvent3 extends Event3<String, String, String, String> {
  @override
  call(state, value1, value2, value3) => '$state $value1 $value2 $value3';
}

void main() {
  test('Parametrized3Event call test', () {
    final event = MockEvent3();
    final objectUnderTest = Parametrized3Event(event, '1', '2', '3');
    expect(objectUnderTest.call('0'), '0 1 2 3');
  });
  test('Parametrized3Event hashCode test', () {
    final event1 = MockEvent3();
    final event2 = MockEvent3();
    final objectUnderTest11 = Parametrized3Event(event1, '1', '2', '3');
    final objectUnderTest12 = Parametrized3Event(event1, '2', '3', '4');
    final objectUnderTest21 = Parametrized3Event(event2, '1', '2', '3');
    final objectUnderTest22 = Parametrized3Event(event1, '1', '2', '3');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Parametrized3Event operator== test', () {
    final event1 = MockEvent3();
    final event2 = MockEvent3();
    final objectUnderTest11 = Parametrized3Event(event1, '1', '2', '3');
    final objectUnderTest12 = Parametrized3Event(event1, '2', '3', '4');
    final objectUnderTest21 = Parametrized3Event(event2, '1', '2', '3');
    final objectUnderTest22 = Parametrized3Event(event1, '1', '2', '3');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
