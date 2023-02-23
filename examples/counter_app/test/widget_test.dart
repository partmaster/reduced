import 'package:counter_app/view/binder.dart';
import 'package:counter_app/view/builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension SingleWidgetByType on CommonFinders {
  T singleWidgetByType<T>(Type type) =>
      find.byType(type).evaluate().single.widget as T;
}

void main() {
  testWidgets('selective rebuild test', (tester) async {
    const app = MyAppBuilder();
    const binder = MyAppStateBinder(child: app);
    await tester.pumpWidget(binder);

    final homePage0 = find.singleWidgetByType(MyHomePageBuilder);
    final counterWidget0 =
        find.singleWidgetByType(MyCounterWidgetBuilder);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    final homePage1 = find.singleWidgetByType(MyHomePageBuilder);
    final counterWidget1 =
        find.singleWidgetByType(MyCounterWidgetBuilder);

    expect(identical(homePage0, homePage1), isTrue);
    expect(identical(counterWidget0, counterWidget1), isFalse);
  });
}
