// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:reduceable/domain.dart';
import 'package:reduceable/reduceable.dart';
import 'package:test/test.dart';

class DecrementCounterReducer extends Reducer<MyAppState> {
  DecrementCounterReducer._();
  factory DecrementCounterReducer() => instance;

  static final instance = DecrementCounterReducer._();

  @override
  MyAppState call(state) =>
      state.copyWith(counter: state.counter - 1);
}

void main() {
  test('testIncrementCounterReducer', () {
    final objectUnderTest = IncrementCounterReducer();
    final state = objectUnderTest.call(
      const MyAppState(title: '', counter: 0),
    );
    expect(state.counter, equals(1));
  });
  test('testMyCounterWidgetProps', () {
    Reduceable<MyAppState> reduceable = Reduceable(
      () => const MyAppState(counter: 0, title: ''),
      (_) {},
      false,
    );
    final objectUnderTest =
        MyCounterWidgetProps.reduceable(reduceable);
    expect(objectUnderTest.counterText, equals('0'));
  });
  test('testMyHomePageProps', () {
    const title = 'Flutter Demo App';
    final incrementReducer = IncrementCounterReducer();
    final decrementReducer = DecrementCounterReducer();
    final reduceable = Reduceable(
      () => const MyAppState(counter: 0, title: title),
      (_) {},
      false,
    );
    final onIncrementPressed =
        Action(reduceable, incrementReducer);
    final onDecrementPressed =
        Action(reduceable, decrementReducer);
    final objectUnderTest = MyHomePageProps.reduceable(reduceable);
    final expected = MyHomePageProps(
      title: title,
      onIncrementPressed: onIncrementPressed,
    );
    final withUnexpectedTitle = MyHomePageProps(
      title: '_$title',
      onIncrementPressed: onIncrementPressed,
    );
    final withUnexpectedCallback = MyHomePageProps(
      title: title,
      onIncrementPressed: onDecrementPressed,
    );
    expect(objectUnderTest, equals(expected));
    expect(objectUnderTest, isNot(equals(withUnexpectedTitle)));
    expect(objectUnderTest, isNot(equals(withUnexpectedCallback)));
  });
}
