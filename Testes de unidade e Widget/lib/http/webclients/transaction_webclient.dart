import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  static const Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting the transaction',
    401: 'Authentication failed',
    409: 'Transaction already exists',
  };

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(
      baseUrl.replace(path: 'transactions'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body);
      return decodedJson
          .map((dynamic json) => Transaction.fromJson(json))
          .toList()
          .reversed
          .toList();
    }

    throw HttpException.getMessage(response.statusCode, _statusCodeResponses);
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    final response = await client.post(
      baseUrl.replace(path: 'transactions'),
      headers: {'password': password},
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException.getMessage(response.statusCode, _statusCodeResponses);
  }
}
