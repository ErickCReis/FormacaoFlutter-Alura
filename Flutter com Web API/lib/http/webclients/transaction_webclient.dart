import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    final response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static const Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting the transaction',
    401: 'Authentication failed',
  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
