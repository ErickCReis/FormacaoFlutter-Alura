import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
  );
}

Future<int> save(Contact contact) async {
  final Database db = await createDatabase();

  return db.insert(
    'contacts',
    contact.toMap(ignoreId: true),
  );
}

Future<List<Contact>> findAll() async {
  final Database db = await createDatabase();

  final List<Map<String, dynamic>> maps = await db.query('contacts');

  List<Contact> contacts = maps.map((map) => Contact.fromMap(map)).toList();

  return contacts;
}
