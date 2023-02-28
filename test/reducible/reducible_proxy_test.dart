import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reducible.dart';

class MockReducer extends Reducer<Object> {
  MockReducer(this.newState);

  Object newState;

  @override
  call(state) => newState;
}

class MockReducible extends Reducible<Object> {
  MockReducible(this.state);

  @override
  Object state;

  @override
  reduce(reducer) => state = reducer(state);
}

void main() {
  test('ReducibleProxy init test', () {
    final reducible = MockReducible('0');
    final objectUnderTest =
        ReducibleProxy(() => reducible.state, reducible.reduce, reducible);
    expect(objectUnderTest.state, '0');
  });
  test('ReducibleProxy reduce test', () {
    final reducible = MockReducible('0');
    final reducer = MockReducer('1');
    final objectUnderTest =
        ReducibleProxy(() => reducible.state, reducible.reduce, reducible);
    objectUnderTest.reduce(reducer);
    expect(objectUnderTest.state, '1');
  });
  test('ReducibleProxy hashCode test', () {
    final reducible = MockReducible('0');
    final objectUnderTest =
        ReducibleProxy(() => reducible.state, reducible.reduce, reducible);
    expect(objectUnderTest.hashCode, reducible.hashCode);
  });
  test('ReducibleProxy operator== test', () {
    final reducible1 = MockReducible('1');
    final objectUnderTest1 =
        ReducibleProxy(() => reducible1.state, reducible1.reduce, reducible1);
    final objectUnderTest3 =
        ReducibleProxy(() => reducible1.state, reducible1.reduce, reducible1);
    final reducible2 = MockReducible('2');
    final objectUnderTest2 =
        ReducibleProxy(() => reducible2.state, reducible2.reduce, reducible2);
    expect(objectUnderTest1, objectUnderTest3);
    expect(objectUnderTest1, isNot(objectUnderTest2));
    expect(objectUnderTest2, isNot(objectUnderTest3));
  });
}
