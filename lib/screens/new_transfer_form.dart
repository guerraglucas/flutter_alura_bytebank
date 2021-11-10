import 'package:bytebank_final/components/editor.dart';
import 'package:bytebank_final/components/transaction_auth_dialog.dart';
import 'package:bytebank_final/http/webclients/transactions_webclient.dart';
import 'package:bytebank_final/models/contact.dart';
import 'package:bytebank_final/models/transaction.dart';
import 'package:flutter/material.dart';
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
  late String userPassword;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TransactionWebclient _webclient = TransactionWebclient();

  void _saveTransfer(BuildContext context, String password) async {
    try {
      await _webclient.save(
        Transaction(
          double.tryParse(_amountController.text),
          Contact(
            0,
            widget.contactName,
            widget.contactAccountNumber,
          ),
        ),
        password.toString(),
      );
      await showDialog(
          context: context,
          builder: (BuildContext contextDialog) {
            return SuccessDialog('successful transfer');
          });
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (err) {
      showDialog(
          context: context,
          builder: (BuildContext contextDialog) {
            return FailureDialog(err.toString());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transferência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
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
