import 'package:bytebank_final/database/app_database.dart';
import 'package:bytebank_final/models/contact.dart';
import 'package:bytebank_final/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          final List<Contact?> _contactList = snapshot.data as List<Contact?>;
          return ListView.builder(
            itemCount: _contactList.length,
            itemBuilder: (context, index) {
              final contact = _contactList[index];
              return _ContactTile(contact!);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future<Contact?> futureContact = Navigator.push<Contact?>(
              context,
              MaterialPageRoute(
                builder: (context) => ContactForm(),
              ),
            );
            futureContact.then((receivedContact) {
              // _updateContacts(receivedContact);
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }

  // void _updateContacts(Contact? receivedContact) {
  //   if (receivedContact != null) {
  //     setState(() {
  //       widget._contactList.add(receivedContact);
  //     });
  //   }
  // }
}

class _ContactTile extends StatelessWidget {
  final Contact _contact;
  const _ContactTile(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contact.contactName.toString(),
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(_contact.contactAccountNumber.toString()),
      ),
    );
  }
}
