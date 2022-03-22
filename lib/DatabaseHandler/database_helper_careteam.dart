import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:memorez/Model/Allergy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Medical.dart';
import 'package:memorez/Model/History.dart';
import 'package:memorez/Model/CareTeam.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db6;

  String careteamTable = 'careteam_table';
  String careteamTable_colID = 'id';
  String colName = 'name';
  String colPhone = 'phone';
  String colStatus = 'status';
  Future<Database> get db6 async {
    _db6 = await _initDb();
    return _db6;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db6';
    // print(path);
    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }


  void _createDb(Database db6, int version) async {
    await db6.execute(
        'CREATE TABLE $careteamTable ($careteamTable_colID INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT, $colPhone TEXT, $colStatus INTEGER)');
  }

  // this is the getMap List

  //good to go, values are returned
  Future<List<Map<String, dynamic>>> getMapCareTeamList() async {
    Database db6 = await this.db6;
    final List<Map<String, dynamic>> result = await db6.query(careteamTable);
    return result;
  }

  //Get List

  Future<List<CareTeam>> getCareTeamList() async {

    final List<Map<String, dynamic>> _careTeamMapList = await getMapCareTeamList();
    final List<CareTeam> _careteamList = [];
    _careTeamMapList.forEach((careTeamMap) {
      _careteamList.add(CareTeam.fromMap(careTeamMap));
    });
    return _careteamList;
  }

  //Insert

  Future<int> insertCareTeam(CareTeam careTeam) async {
    Database db6 = await this.db6;
    final int result = await db6.insert(careteamTable, careTeam.toMap());
    return result;
  }

  //Update

  Future<int> updateCareTeam (CareTeam careTeam) async {
    Database db6 = await this.db6;
    final int result = await db6.update(careteamTable, careTeam.toMap(),
        where: '$careteamTable_colID = ?', whereArgs: [careTeam.id]);
    return result;
  }

  //Delete

  Future<int> deleteCareTeam(int? id) async {
    Database db6 = await this.db6;
    final int result =
    await db6.delete(careteamTable, where: '$careteamTable_colID = ?', whereArgs: [id]);
    return result;
  }













}