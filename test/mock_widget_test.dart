import 'package:counter_app/builder.dart';
import 'package:counter_app/mock/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('testBuilder', (tester) async {
    const title = 'title';
    const counterText = '0';
    final onIncrementPressed = MockCallable();
    final app = MyMockPropsBinder(
      props: MyMockProps(
        title: title,
        counterText: '0',
        onIncrementPressed: onIncrementPressed,
      ),
      child: const MyAppBuilder(),
    );
    await tester.pumpWidget(app);
    expect(find.widgetWithText(AppBar, title), findsOneWidget);
    expect(
      find.widgetWithText(MyCounterWidgetBuilder, counterText),
      findsOneWidget,
    );
    await tester.tap(find.byIcon(Icons.add));
    expect(onIncrementPressed.count, equals(1));
  });
}
