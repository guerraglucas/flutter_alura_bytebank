import 'package:bytebank_final/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContactsDao {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _contactName = 'contact_name';
  static const String _contactAccountNumber = 'contact_account_number';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_contactName TEXT, '
      '$_contactAccountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    Map<String, dynamic> contactMap = _toMap(contact);
    final Database db = await getDatabase();
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_contactName] = contact.contactName;
    contactMap[_contactAccountNumber] = contact.contactAccountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> table = await db.query(_tableName);
    final List<Contact> contacts = _toList(table);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> table) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in table) {
      final Contact contact = Contact(
        row[_id],
        row[_contactName],
        row[_contactAccountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }

  static Future<int> deleteContact(int id) async {
    final Database db = await getDatabase();
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
