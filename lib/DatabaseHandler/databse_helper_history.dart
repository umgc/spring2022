import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:memorez/Model/Allergy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Medical.dart';
import 'package:memorez/Model/History.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db4;

  String historyTable = 'history_table';
  String historyTable_colID = 'id';
  String colHistory = 'history';
  String colDesc = 'desc';
  String colStatus = 'status';
  Future<Database> get db4 async {
    _db4 = await _initDb();
    return _db4;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db4';
    // print(path);
    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }


  void _createDb(Database db4, int version) async {
    await db4.execute(
        'CREATE TABLE $historyTable ($historyTable_colID INTEGER PRIMARY KEY AUTOINCREMENT,$colHistory TEXT, $colDesc TEXT, $colStatus INTEGER)');
  }

  // this is the getMap List

  //good to go, values are returned
  Future<List<Map<String, dynamic>>> getMapHistoryList() async {
    Database db4 = await this.db4;
    final List<Map<String, dynamic>> result = await db4.query(historyTable);
    return result;
  }

  //Get List

  Future<List<History>> getHistoryList() async {

    final List<Map<String, dynamic>> _historyMapList = await getMapHistoryList();
    final List<History> _historyList = [];
    _historyMapList.forEach((historyMap) {
      _historyList.add(History.fromMap(historyMap));
    });
    return _historyList;
  }

  //Insert

  Future<int> insertHistory(History history) async {
    Database db4 = await this.db4;
    final int result = await db4.insert(historyTable, history.toMap());
    return result;
  }

  //Update

  Future<int> updateHistory (History history) async {
    Database db4 = await this.db4;
    final int result = await db4.update(historyTable, history.toMap(),
        where: '$historyTable_colID = ?', whereArgs: [history.id]);
    return result;
  }

  //Delete

  Future<int> deleteHistory(int? id) async {
    Database db4 = await this.db4;
    final int result =
    await db4.delete(historyTable, where: '$historyTable_colID = ?', whereArgs: [id]);
    return result;
  }













}