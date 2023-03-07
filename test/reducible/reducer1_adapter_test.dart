import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/src/reducer.dart';

class MockReducer1 extends Reducer1<String, String> {
  @override
  call(state, value) => '$state $value';
}

void main() {
  test('Reducer1Adapter call test', () {
    final reducer = MockReducer1();
    final objectUnderTest = Reducer1Adapter(reducer, '1');
    expect(objectUnderTest.call('0'), '0 1');
  });
  test('Reducer1Adapter hashCode test', () {
    final reducer1 = MockReducer1();
    final reducer2 = MockReducer1();
    final objectUnderTest11 = Reducer1Adapter(reducer1, '1');
    final objectUnderTest12 = Reducer1Adapter(reducer1, '2');
    final objectUnderTest21 = Reducer1Adapter(reducer2, '1');
    final objectUnderTest22 = Reducer1Adapter(reducer1, '1');
    expect(objectUnderTest11.hashCode, objectUnderTest22.hashCode);
    expect(objectUnderTest11.hashCode,
        isNot(objectUnderTest12.hashCode));
    expect(objectUnderTest11.hashCode,
        isNot(objectUnderTest21.hashCode));
    expect(objectUnderTest12.hashCode,
        isNot(objectUnderTest21.hashCode));
  });
  test('Reducer1Adapter operator== test', () {
    final reducer1 = MockReducer1();
    final reducer2 = MockReducer1();
    final objectUnderTest11 = Reducer1Adapter(reducer1, '1');
    final objectUnderTest12 = Reducer1Adapter(reducer1, '2');
    final objectUnderTest21 = Reducer1Adapter(reducer2, '1');
    final objectUnderTest22 = Reducer1Adapter(reducer1, '1');
    expect(objectUnderTest11, objectUnderTest22);
    expect(objectUnderTest11, isNot(objectUnderTest12));
    expect(objectUnderTest11, isNot(objectUnderTest21));
    expect(objectUnderTest12, isNot(objectUnderTest21));
  });
}
