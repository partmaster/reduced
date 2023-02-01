// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:counter_app/binder.dart';
import 'package:counter_app/builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    const app = MyAppBuilder();
    const provider = MyAppStateBinder(child: app);
    await tester.pumpWidget(provider);

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    final homePageFinder0 = find.byType(MyHomePageBuilder);
    expect(homePageFinder0, findsOneWidget);
    final homePage0 = homePageFinder0.evaluate().single.widget;

    final counterWidgetFinder0 = find.byType(MyCounterWidgetBuilder);
    expect(counterWidgetFinder0, findsOneWidget);
    final counterWidget0 =
        counterWidgetFinder0.evaluate().single.widget;

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    final homePageFinder1 = find.byType(MyHomePageBuilder);
    expect(homePageFinder1, findsOneWidget);
    final homePage1 = homePageFinder1.evaluate().single.widget;

    final counterWidgetFinder1 = find.byType(MyCounterWidgetBuilder);
    expect(counterWidgetFinder1, findsOneWidget);
    final counterWidget1 =
        counterWidgetFinder1.evaluate().single.widget;

    expect(
      identical(counterWidget0, counterWidget1),
      isFalse,
      reason:
          'counterWidget was not rebuild $counterWidget0, $counterWidget1',
    );

    expect(
      identical(homePage0, homePage1),
      isTrue,
      reason: 'homePage was rebuild $homePage0, $homePage1',
    );
  });
}
