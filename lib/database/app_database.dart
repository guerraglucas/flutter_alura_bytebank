import 'package:bytebank_final/database/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactsDao.tableSql);
    },
    onDowngrade: onDatabaseDowngradeDelete,
    version: 1,
  );
}
