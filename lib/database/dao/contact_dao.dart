import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE contacts('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query('contacts');
    final List<Contact> contacts = List();
    for (Map<String, dynamic> map in result) {
      final Contact contact = Contact(
        map['id'],
        map['name'],
        map['account_number'],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
