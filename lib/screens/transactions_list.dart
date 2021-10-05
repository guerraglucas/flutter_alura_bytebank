import 'package:bytebank_final/components/centered_message.dart';
import 'package:bytebank_final/http/webclient.dart';
import 'package:bytebank_final/components/loading_circle.dart';

import 'package:bytebank_final/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
      ),
      body: FutureBuilder<List<Transaction>>(
          initialData: const [],
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;

              case ConnectionState.waiting:
                return LoadingCircle();

              case ConnectionState.active:
                break;

              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> _transactionList =
                      snapshot.data as List<Transaction>;
                  if (_transactionList.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = _transactionList[index];

                        return _TransactionTile(transaction: transaction);
                      },
                      itemCount: _transactionList.length,
                    );
                  }
                }
                return CenteredMessage(
                  'Nenhuma transferência encontrada',
                  icon: Icons.warning,
                );
            }
            return CenteredMessage('Unknown Error');
          }),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction? transaction;

  const _TransactionTile({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transaction!.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transaction!.contact.contactAccountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
