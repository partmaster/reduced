import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/event.dart';

class MockReducer2 extends Event2<String, String, String> {
  @override
  call(state, value1, value2) => '$state $value1 $value2';
}

void main() {
  test('Reducer2Adapter call test', () {
    final reducer = MockReducer2();
    final objectUnderTest = Event2Adapter(reducer, '1', '2');
    expect(objectUnderTest.call('0'), '0 1 2');
  });
  test('Reducer2Adapter hashCode test', () {
    final reducer1 = MockReducer2();
    final reducer2 = MockReducer2();
    final objectUnderTest11 = Event2Adapter(reducer1, '1', '2');
    final objectUnderTest12 = Event2Adapter(reducer1, '2', '3');
    final objectUnderTest21 = Event2Adapter(reducer2, '1', '2');
    final objectUnderTest22 = Event2Adapter(reducer1, '1', '2');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Reducer2Adapter operator== test', () {
    final reducer1 = MockReducer2();
    final reducer2 = MockReducer2();
    final objectUnderTest11 = Event2Adapter(reducer1, '1', '2');
    final objectUnderTest12 = Event2Adapter(reducer1, '2', '3');
    final objectUnderTest21 = Event2Adapter(reducer2, '1', '2');
    final objectUnderTest22 = Event2Adapter(reducer1, '1', '2');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
