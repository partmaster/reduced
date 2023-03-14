import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';

class MockEvent1 extends Event1<String, String> {
  @override
  call(state, value) => '$state $value';
}

void main() {
  test('Event1Adapter call test', () {
    final reducer = MockEvent1();
    final objectUnderTest = Event1Adapter(reducer, '1');
    expect(objectUnderTest.call('0'), '0 1');
  });
  test('Event1Adapter hashCode test', () {
    final reducer1 = MockEvent1();
    final reducer2 = MockEvent1();
    final objectUnderTest11 = Event1Adapter(reducer1, '1');
    final objectUnderTest12 = Event1Adapter(reducer1, '2');
    final objectUnderTest21 = Event1Adapter(reducer2, '1');
    final objectUnderTest22 = Event1Adapter(reducer1, '1');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Event1Adapter operator== test', () {
    final reducer1 = MockEvent1();
    final reducer2 = MockEvent1();
    final objectUnderTest11 = Event1Adapter(reducer1, '1');
    final objectUnderTest12 = Event1Adapter(reducer1, '2');
    final objectUnderTest21 = Event1Adapter(reducer2, '1');
    final objectUnderTest22 = Event1Adapter(reducer1, '1');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
