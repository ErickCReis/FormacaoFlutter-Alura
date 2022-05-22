import 'dart:async';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/utils/currency_input_formatter.dart';
import 'package:bytebank/utils/format.dart';
import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/error.dart';
import 'package:bytebank/widgets/progress/progress_view.dart';
import 'package:bytebank/widgets/transaction_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class FatalErrorFormState extends TransactionFormState {
  final String message;

  const FatalErrorFormState(this.message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowFormState());

  void save(
    Transaction transaction,
    String password,
    BuildContext context,
  ) {
    emit(const SendingState());
    _send(transaction, password, context);
  }

  void _send(
    Transaction transaction,
    String password,
    BuildContext context,
  ) async {
    TransactionWebClient()
        .save(transaction, password)
        .then((transaction) => emit(const SentState()))
        .catchError(
      (e) {
        emit(FatalErrorFormState(e.message));
      },
      test: (e) => e is HttpException,
    ).catchError(
      (_) {
        emit(const FatalErrorFormState('Timeout submitting the transaction'));
      },
      test: (e) => e is TimeoutException,
    ).catchError(
      (e) {
        emit(FatalErrorFormState(e.message));
      },
    );
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  const TransactionFormContainer(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionFormCubit(),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (blocContext, state) {
          if (state is SentState) {
            Navigator.pop(blocContext);
          }
        },
        child: TransactionFormView(_contact),
      ),
    );
  }
}

class TransactionFormView extends StatelessWidget {
  final Contact _contact;

  const TransactionFormView(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (_, state) {
        if (state is ShowFormState) {
          return _BasicForm(_contact);
        }

        if (state is SendingState || state is SentState) {
          return const ProgressView();
        }

        if (state is FatalErrorFormState) {
          return ErrorView(state.message);
        }

        return const ErrorView('Unknown error');
      },
    );
  }
}

class _BasicForm extends StatefulWidget {
  final Contact _contact;

  const _BasicForm(this._contact, {Key? key}) : super(key: key);

  @override
  State<_BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<_BasicForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();
  bool? _isValid;

  void _checkValue(String value) {
    setState(() => _isValid = parseCurrency(value) > 0);
  }

  void _submit() {
    final double value = parseCurrency(_valueController.text);

    showDialog(
      context: context,
      builder: (_) => TransactionAuthDialog(
        onConfirm: (String password) {
          final Transaction transaction = Transaction(
            transactionId,
            value,
            widget._contact,
          );

          BlocProvider.of<TransactionFormCubit>(context)
              .save(transaction, password, context);
        },
      ),
    );
  }

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
                widget._contact.name,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  widget._contact.accountNumber.toString(),
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
                  onChanged: _checkValue,
                  inputFormatters: [
                    CurrencyInputFormatter(),
                  ],
                  autofocus: true,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    labelText: 'Value',
                    hintText: '\$0.00',
                    errorText: _isValid != false ? null : 'Invalid value',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: _isValid != true ? null : _submit,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
