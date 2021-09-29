import 'package:bytebank_final/components/editor.dart';
import 'package:bytebank_final/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Editor(
                controller: _contactNameController,
                fieldHint: 'João da Silva',
                fieldName: 'Nome Completo',
                icon: Icon(Icons.perm_contact_cal, color: Colors.orange[800]),
                keyboardType: TextInputType.text,
              ),
              Editor(
                controller: _accountNumberController,
                fieldHint: '00000',
                fieldName: 'Número da conta',
                icon: Icon(Icons.account_balance, color: Colors.orange[800]),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        _createContact(context);
                      },
                      child: Text('Confirmar')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createContact(BuildContext context) {
    final String? contactName = _contactNameController.text;
    final int? contactAccountNumber =
        int.tryParse(_accountNumberController.text);
    if (contactName != null && contactAccountNumber != null) {
      final createdContact = Contact(0, contactName, contactAccountNumber);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$createdContact'),
        ),
      );
      Navigator.pop(context, createdContact);
    }
  }
}
