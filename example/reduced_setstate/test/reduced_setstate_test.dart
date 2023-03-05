// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

extension SingleWidgetByType on CommonFinders {
  T singleWidgetByType<T>(Type type) =>
      find.byType(type).evaluate().single.widget as T;
}

class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}

void main() {
  testWidgets('Reducible reduce test', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(
        initialState: 0,
        child: wrapWithConsumer<int, int>(
          builder: ({Key? key, required int props}) => const SizedBox(),
          transformer: (reducible) => reducible.state,
        ),
      ),
    );

    final InheritedValueWidget<ReducibleAndState<int>> widget =
        find.singleWidgetByType(InheritedValueWidget<ReducibleAndState<int>>);

    final objectUnderTest = widget.value.reducible;
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });
}
