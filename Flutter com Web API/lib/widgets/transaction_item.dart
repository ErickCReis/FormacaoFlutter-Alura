import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/utils/format.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem(
    this.transaction, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(
          formatCurrency(transaction.value),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction.contact.accountNumber.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              formatDate(transaction.date),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
