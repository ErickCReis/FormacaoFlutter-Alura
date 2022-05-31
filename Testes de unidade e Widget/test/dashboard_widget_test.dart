import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Should display the transfer feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));

    final iconTransferFeatureItem =
        find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    expect(iconTransferFeatureItem, findsOneWidget);

    final nameTransferFeatureItem =
        find.widgetWithText(FeatureItem, 'Transfer');
    expect(nameTransferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transation feed feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Dashboard()));

    final trasactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));

    expect(trasactionFeedFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}
