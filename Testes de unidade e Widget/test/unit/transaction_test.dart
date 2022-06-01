import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the value when create a trasaction', () {
    final transaction = Transaction(
      '0',
      200,
      Contact(0, 'Test', 1000),
    );

    expect(transaction.id, '0');
    expect(transaction.value, 200);
  });

  test('Should show error when create transaction with value less than zero',
      () {
    expect(
      () => Transaction(
        '0',
        -200,
        Contact(0, 'Test', 1000),
      ),
      throwsAssertionError,
    );
  });
}
