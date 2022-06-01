import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';

void main() {
  group('When Dashboard is opened', () {
    testWidgets('Should display the main image', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Dashboard()));

      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets('Should display the transfer feature', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Dashboard()));

      final iconTransferFeatureItem =
          find.widgetWithIcon(FeatureItem, Icons.monetization_on);
      expect(iconTransferFeatureItem, findsOneWidget);

      final nameTransferFeatureItem =
          find.widgetWithText(FeatureItem, 'Transfer');
      expect(nameTransferFeatureItem, findsOneWidget);
    });

    testWidgets('Should display the transation feed feature', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Dashboard()));

      final trasactionFeedFeatureItem = find.byWidgetPredicate(
        (widget) =>
            featureItemMatcher(widget, 'Transaction Feed', Icons.description),
      );

      expect(trasactionFeedFeatureItem, findsOneWidget);
    });
  });
}
