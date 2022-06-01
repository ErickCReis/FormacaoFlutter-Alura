import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/contact_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'actions.dart';
import 'transfer_flow.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    when(mockContactDao.findAll())
        .thenAnswer((_) async => [Contact(0, 'Test', 123)]);
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
  });
}
