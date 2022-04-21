import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/centered_message.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:bytebank/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Progress();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              final List<Transaction> transactions = snapshot.data ?? [];

              if (transactions.isEmpty) {
                return const CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
              }

              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final Transaction transaction = transactions[index];
                  return TransactionItem(transaction);
                },
              );
            }

            return const CenteredMessage('Unknown error');
          },
        ));
  }
}
