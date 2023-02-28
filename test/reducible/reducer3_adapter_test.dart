import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reducible.dart';

class MockReducer3 extends Reducer3<String, String, String, String> {
  @override
  call(state, value1, value2, value3) => '$state $value1 $value2 $value3';
}


void main() {
  test('Reducer3Adapter call test', () {
    final reducer = MockReducer3();
    final objectUnderTest = Reducer3Adapter(reducer, '1', '2', '3');
    expect(objectUnderTest.call('0'), '0 1 2 3');
  });
  test('Reducer3Adapter hashCode test', () {
    final reducer1 = MockReducer3();
    final reducer2 = MockReducer3();
    final objectUnderTest11 = Reducer3Adapter(reducer1, '1', '2', '3');
    final objectUnderTest12 = Reducer3Adapter(reducer1, '2', '3', '4');
    final objectUnderTest21 = Reducer3Adapter(reducer2, '1', '2', '3');
    final objectUnderTest22 = Reducer3Adapter(reducer1, '1', '2', '3');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode, isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode, isNot(objectUnderTest21.hashCode));
  });
  test('Reducer3Adapter operator== test', () {
    final reducer1 = MockReducer3();
    final reducer2 = MockReducer3();
    final objectUnderTest11 = Reducer3Adapter(reducer1, '1', '2', '3');
    final objectUnderTest12 = Reducer3Adapter(reducer1, '2', '3', '4');
    final objectUnderTest21 = Reducer3Adapter(reducer2, '1', '2', '3');
    final objectUnderTest22 = Reducer3Adapter(reducer1, '1', '2', '3');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
