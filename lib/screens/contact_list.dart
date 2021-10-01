import 'package:bytebank_final/database/dao/contacts_dao.dart';
import 'package:bytebank_final/models/contact.dart';
import 'package:bytebank_final/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactsDao _dao = ContactsDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Loading'),
                    )
                  ],
                ),
              );

            case ConnectionState.active:
              break;

            case ConnectionState.done:
              final List<Contact> _contactList = snapshot.data as List<Contact>;

              return ListView.builder(
                itemCount: _contactList.length,
                itemBuilder: (context, index) {
                  final contact = _contactList[index];
                  return _ContactTile(contact);
                },
              );
          }
          return Text('Unknown Error');
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push<Contact?>(
              context,
              MaterialPageRoute(
                builder: (context) => ContactForm(),
              ),
            ).then((value) => setState(() {}));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
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
