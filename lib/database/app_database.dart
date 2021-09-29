import 'package:bytebank_final/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY, '
            'contact_name TEXT, '
            'contact_account_number INTEGER)');
      },
      onDowngrade: onDatabaseDowngradeDelete,
      version: 1,
    );
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {};
    contactMap['contact_name'] = contact.contactName;
    contactMap['contact_account_number'] = contact.contactAccountNumber;
    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['contact_name'],
          map['contact_account_number'],
        );
        contacts.add(contact);
      }
      return contacts;
    });
  });
}
