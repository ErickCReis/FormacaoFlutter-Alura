import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'dashboard_widget_test.mocks.dart';
import '../matchers.dart';

@GenerateMocks([ContactDao])
void main() {
  group('When Dashboard is opened', () {
    late MockContactDao mockContactDao;

    setUp(() {
      mockContactDao = MockContactDao();
    });

    testWidgets('Should display the main image', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(
          contactDao: mockContactDao,
        ),
      ));

      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets('Should display the transfer feature', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(
          contactDao: mockContactDao,
        ),
      ));

      final iconTransferFeatureItem =
          find.widgetWithIcon(FeatureItem, Icons.monetization_on);
      expect(iconTransferFeatureItem, findsOneWidget);

      final nameTransferFeatureItem =
          find.widgetWithText(FeatureItem, 'Transfer');
      expect(nameTransferFeatureItem, findsOneWidget);
    });

    testWidgets('Should display the transation feed feature', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(
          contactDao: mockContactDao,
        ),
      ));

      final trasactionFeedFeatureItem = find.byWidgetPredicate(
        (widget) =>
            featureItemMatcher(widget, 'Transaction Feed', Icons.description),
      );

      expect(trasactionFeedFeatureItem, findsOneWidget);
    });
  });
}
