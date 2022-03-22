import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:memorez/Model/Allergy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Medical.dart';
import 'package:memorez/Model/History.dart';
import 'package:memorez/Model/Transportation.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db5;

  String transportationTable = 'transportation_table';
  String transportationTable_colID = 'id';
  String colName = 'name';
  String colPhone = 'phone';
  String colStatus = 'status';
  Future<Database> get db5 async {
    _db5 = await _initDb();
    return _db5;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db5';
    // print(path);
    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }


  void _createDb(Database db5, int version) async {
    await db5.execute(
        'CREATE TABLE $transportationTable ($transportationTable_colID INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT, $colPhone TEXT, $colStatus INTEGER)');
  }

  // this is the getMap List

  //good to go, values are returned
  Future<List<Map<String, dynamic>>> getMapTransportationList() async {
    Database db5 = await this.db5;
    final List<Map<String, dynamic>> result = await db5.query(transportationTable);
    return result;
  }

  //Get List

  Future<List<Transportation>> getTransportationList() async {

    final List<Map<String, dynamic>> _transportationMapList = await getMapTransportationList();
    final List<Transportation> _transportationList = [];
    _transportationMapList.forEach((transportationMap) {
      _transportationList.add(Transportation.fromMap(transportationMap));
    });
    return _transportationList;
  }

  //Insert

  Future<int> insertTransportation(Transportation transportation) async {
    Database db5 = await this.db5;
    final int result = await db5.insert(transportationTable, transportation.toMap());
    return result;
  }

  //Update

  Future<int> updateTransportation (Transportation transportation) async {
    Database db5 = await this.db5;
    final int result = await db5.update(transportationTable, transportation.toMap(),
        where: '$transportationTable_colID = ?', whereArgs: [transportation.id]);
    return result;
  }

  //Delete

  Future<int> deleteTransportation(int? id) async {
    Database db5 = await this.db5;
    final int result =
    await db5.delete(transportationTable, where: '$transportationTable_colID = ?', whereArgs: [id]);
    return result;
  }













}