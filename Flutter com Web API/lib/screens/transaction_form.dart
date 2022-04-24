import 'dart:async';

import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:bytebank/widgets/response_dialog.dart';
import 'package:bytebank/widgets/transaction_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = const Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: _sending
                        ? const Progress(
                            message: 'Sending...',
                            direction: Axis.horizontal,
                            progressSize: 24,
                            progressColor: Colors.white,
                          )
                        : const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);

                      if (_sending || value == null) {
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) => TransactionAuthDialog(
                          onConfirm: (String password) {
                            final Transaction transaction = Transaction(
                              transactionId,
                              value,
                              widget.contact,
                            );

                            _save(transaction, password, context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(
    Transaction transaction,
    String password,
    BuildContext context,
  ) async {
    final transactionResult = await _send(transaction, password, context);

    _showSuccessMessage(context, transactionResult);
  }

  Future<Transaction?> _send(
    Transaction transaction,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });

    return _webClient.save(transaction, password).catchError(
      (e) {
        _showFailureMessage(context, message: e.message);
      },
      test: (e) => e is HttpException,
    ).catchError(
      (_) {
        _showFailureMessage(
          context,
          message: 'Timeout submitting the transaction',
        );
      },
      test: (e) => e is TimeoutException,
    ).catchError(
      (e) {
        _showFailureMessage(context);
      },
    ).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
  }

  void _showFailureMessage(
    BuildContext context, {
    String message = 'Unknown error',
  }) {
    showDialog(
      context: context,
      builder: (_) => FailureDialog(message),
    );
  }

  void _showSuccessMessage(
    BuildContext context,
    Transaction? transaction,
  ) async {
    if (transaction == null) {
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => const SuccessDialog('Transaction success'),
    );

    Navigator.of(context).pop();
  }
}
