import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:memorez/Model/Allergy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Medical.dart';
import 'package:memorez/Model/History.dart';
import 'package:memorez/Model/Contacts.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db7;

  String contactTable = 'contact_table';
  String contactTable_colID = 'id';
  String colName = 'name';
  String colPhone = 'phone';
  String colStatus = 'status';
  Future<Database> get db7 async {
    _db7 = await _initDb();
    return _db7;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db7';
    // print(path);
    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }


  void _createDb(Database db7, int version) async {
    await db7.execute(
        'CREATE TABLE $contactTable ($contactTable_colID INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT, $colPhone TEXT, $colStatus INTEGER)');
  }

  // this is the getMap List

  //good to go, values are returned
  Future<List<Map<String, dynamic>>> getMapContactList() async {
    Database db7 = await this.db7;
    final List<Map<String, dynamic>> result = await db7.query(contactTable);
    return result;
  }

  //Get List

  Future<List<Contact>> getContactList() async {

    final List<Map<String, dynamic>> _contactMapList = await getMapContactList();
    final List<Contact> _contactList = [];
    _contactMapList.forEach((contactMap) {
      _contactList.add(Contact.fromMap(contactMap));
    });
    return _contactList;
  }

  //Insert

  Future<int> insertContact(Contact contact) async {
    Database db7 = await this.db7;
    final int result = await db7.insert(contactTable, contact.toMap());
    return result;
  }

  //Update

  Future<int> updateContact (Contact contact) async {
    Database db7 = await this.db7;
    final int result = await db7.update(contactTable, contact.toMap(),
        where: '$contactTable_colID = ?', whereArgs: [contact.id]);
    return result;
  }

  //Delete

  Future<int> deleteContact(int? id) async {
    Database db7 = await this.db7;
    final int result =
    await db7.delete(contactTable, where: '$contactTable_colID = ?', whereArgs: [id]);
    return result;
  }
  
}