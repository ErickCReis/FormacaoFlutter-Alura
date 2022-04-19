import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = [];

  TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactions.add(Transaction(100, Contact(0, 'Erick', 1000)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final Transaction transaction = transactions[index];
          return TransactionItem(transaction);
        },
      ),
    );
  }
}
