import 'package:examples/mock/mock_reducible.dart';
import 'package:examples/view/builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inherited_widgets/inherited_widgets.dart';

void main() {
  testWidgets('testBuilder', (tester) async {
    const title = 'title';
    const counterText = '0';
    final onIncrementPressed = MockCallable();
    final app = InheritedValueWidget(
      value: MyMockProps(
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
