import 'dart:async';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:bytebank/widgets/centered_message.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:bytebank/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: dependecies.transactionWebClient.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Progress();
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const CenteredMessage('Unknown error');
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            if (error is HttpException) {
              return CenteredMessage(error.message);
            }

            if (error is TimeoutException) {
              return const CenteredMessage('Timeout getting transactions');
            }

            return const CenteredMessage('Unknown error');
          }

          if (!snapshot.hasData) {
            return const CenteredMessage(
              'No transactions found',
              icon: Icons.warning,
            );
          }

          final List<Transaction> transactions = snapshot.requireData;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final Transaction transaction = transactions[index];
              return TransactionItem(transaction);
            },
          );
        },
      ),
    );
  }
}
