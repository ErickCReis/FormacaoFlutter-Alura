import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();

    return db.insert(
      _tableName,
      toMap(contact),
    );
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return _tolist(result);
  }

  Map<String, dynamic> toMap(Contact contact) {
    return {
      _name: contact.name,
      _accountNumber: contact.accountNumber,
    };
  }

  List<Contact> _tolist(List<Map<String, dynamic>> result) {
    return result
        .map((row) => Contact(row[_id], row[_name], row[_accountNumber]))
        .toList();
  }
}
