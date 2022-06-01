import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/contact_item.dart';
import 'package:bytebank/widgets/transaction_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers.dart';
import 'actions.dart';
import 'transfer_flow.mocks.dart';

@GenerateMocks([ContactDao, TransactionWebClient])
void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final testContact = Contact(0, 'Test', 123);

    final mockContactDao = MockContactDao();
    when(mockContactDao.findAll()).thenAnswer((_) async => [testContact]);
    when(mockContactDao.save(any)).thenAnswer((_) async => 1);

    final mockTransactionWebClient = MockTransactionWebClient();
    when(mockTransactionWebClient.save(any, any)).thenAnswer(
      (_) async => Transaction('0', 200, testContact),
    );

    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTranferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Test' &&
            widget.contact.accountNumber == 123;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Test');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('123');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate(
      (widget) => textFieldByLabelTextMatcher(widget, 'Value'),
    );
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200.00');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transationAuthDialog = find.byType(TransactionAuthDialog);
    expect(transationAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    verify(mockTransactionWebClient.save(
      Transaction('0', 200, testContact),
      '1000',
    )).called(1);

    final successDialog = find.byType(AlertDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}
