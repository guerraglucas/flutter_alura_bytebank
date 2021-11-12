import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bytebank_final/http/webclient.dart';
import 'package:bytebank_final/models/transaction.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final http.Response response = await client.get(baseUrl);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<http.Response> save(Transaction transaction, String password) async {
    String transactionJson = jsonEncode(transaction);
    await Future.delayed(Duration(seconds: 2));
    final http.Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': password},
        body: transactionJson);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw HttpException(_statusCodeResponses[response.statusCode]!);
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already made'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
