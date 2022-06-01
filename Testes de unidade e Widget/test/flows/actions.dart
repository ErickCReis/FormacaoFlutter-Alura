import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';

Future<void> clickOnTheTranferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate(
    (widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on),
  );
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}
