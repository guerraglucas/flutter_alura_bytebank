import 'dart:convert';

import 'package:bytebank_final/models/contact.dart';
import 'package:bytebank_final/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response');
    print('status: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

final Uri baseUrl = Uri.parse('http://172.20.0.203:8080/transactions');
final http.Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

Future<List<Transaction>> findAll() async {
  final http.Response response =
      await client.get(baseUrl).timeout(Duration(seconds: 10));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ));
    transactions.add(transaction);
  }

  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.contactName,
      'accountNumber': transaction.contact.contactAccountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);
  final http.Response response = await client.post(baseUrl,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson);
  final Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
