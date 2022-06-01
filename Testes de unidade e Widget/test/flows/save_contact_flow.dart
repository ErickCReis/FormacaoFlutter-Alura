import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers.dart';
import 'actions.dart';
import 'save_contact_flow.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    when(mockContactDao.findAll()).thenAnswer((_) async => []);
    when(mockContactDao.save(any)).thenAnswer((_) async => 1);

    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTranferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find
        .byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Test');

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '123');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(0, 'Test', 123))).called(1);

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);
  });
}
