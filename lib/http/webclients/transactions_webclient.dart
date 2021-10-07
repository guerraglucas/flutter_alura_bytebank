import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bytebank_final/http/webclient.dart';
import 'package:bytebank_final/models/transaction.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final http.Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    List<Transaction> transactions = jsonDecode(response.body)
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    String transactionJson = jsonEncode(transaction);
    final http.Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
