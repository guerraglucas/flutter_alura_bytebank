import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bytebank_final/http/webclient.dart';
import 'package:bytebank_final/models/transaction.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final http.Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    List<Transaction> transactions = _toListOfMap(response);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    String transactionJson = jsonEncode(transaction);
    final http.Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);
    return _toTransaction(response);
  }

  List<Transaction> _toListOfMap(http.Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionMap in decodedJson) {
      transactions.add(Transaction.fromJson(transactionMap));
    }
    return transactions;
  }

  Transaction _toTransaction(http.Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
