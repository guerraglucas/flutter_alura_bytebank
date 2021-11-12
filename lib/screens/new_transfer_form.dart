import 'dart:async';
import 'package:bytebank_final/components/editor.dart';
import 'package:bytebank_final/components/loading_circle.dart';
import 'package:bytebank_final/components/transaction_auth_dialog.dart';
import 'package:bytebank_final/http/webclients/transactions_webclient.dart';
import 'package:bytebank_final/models/contact.dart';
import 'package:bytebank_final/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../components/response_dialog.dart';

class TransferForm extends StatefulWidget {
  const TransferForm(
      {Key? key,
      @required this.contactName,
      @required this.contactAccountNumber})
      : assert(contactName != null),
        assert(contactAccountNumber != null),
        super(key: key);

  final int? contactAccountNumber;
  final String? contactName;

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  bool _sending = false;
  final String transactionId = Uuid().v4();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TransactionWebclient _webclient = TransactionWebclient();

  void _saveTransfer(BuildContext context, String password) async {
    setState(() {
      _sending = true;
    });
    try {
      await _send(password);
      await _showSuccessfulMessage(context);
    } catch (err) {
      if (err is TimeoutException) {
        _showFailureMessage(context, message: 'timeout exception');
      } else if (err is HttpException) {
        _showFailureMessage(context, message: err.message);
      } else {
        _showFailureMessage(context, message: err as String);
      }
    }
    setState(() {
      _sending = false;
    });
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'unknown error'}) {
    showDialog(
        context: context,
        builder: (BuildContext contextDialog) {
          return FailureDialog(message);
        });
  }

  Future<void> _send(String password) async {
    await _webclient.save(
      Transaction(
        transactionId,
        double.tryParse(_amountController.text),
        Contact(
          0,
          widget.contactName,
          widget.contactAccountNumber,
        ),
      ),
      password.toString(),
    );
  }

  Future<void> _showSuccessfulMessage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext contextDialog) {
          return SuccessDialog('successful transfer');
        });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print('transaction form id: $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transferência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Visibility(visible: _sending, child: LinearProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.contactName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Número da conta:'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.contactAccountNumber}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Editor(
              controller: _amountController,
              fieldHint: '000.00',
              fieldName: 'Valor',
              keyboardType: TextInputType.number,
              icon: Icon(
                Icons.monetization_on,
              ),
            ),
            Editor(
              controller: _descriptionController,
              fieldHint: 'Pagamento',
              fieldName: 'Descrição',
              keyboardType: TextInputType.text,
              icon: Icon(Icons.notes),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                  onPressed: () async {
                    //Inserir AlertDialog

                    await showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return TransactionAuthDialog(
                            onConfirm: (passwordController) {
                              Navigator.pop(context);
                              return _saveTransfer(context, passwordController);
                            },
                          );
                        });
                  },
                  child: Text('Confirmar Transferência')),
            ),
          ],
        ),
      ),
    );
  }
}
