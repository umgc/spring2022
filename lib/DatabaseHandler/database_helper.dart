import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db2;

  String medicationTable = 'medication_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDose= 'dose';
  String colStatus = 'status';



  Future<Database> get db2 async {
    _db2 = await _initDb();
    return _db2;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db';
    print(path);
    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }

  void _createDb(Database db2, int version) async {
    await db2.execute(
        'CREATE TABLE $medicationTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT, $colDose TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getMapMedicationList() async {
    Database db2 = await this.db2;
    final List<Map<String, dynamic>> result = await db2.query(medicationTable);
    return result;
  }

  Future<List<Medication>> getMedicationList() async {
    final List<Map<String, dynamic>> medicationMapList = await getMapMedicationList();
    final List<Medication> medicationList = [];
    medicationMapList.forEach((medicationMap) {
      medicationList.add(Medication.fromMap(medicationMap));
    });
    return medicationList;
  }

  Future<int> insertMedication(Medication medication) async {
    Database db2 = await this.db2;
    final int result = await db2.insert(medicationTable, medication.toMap());
    return result;
  }

  Future<int> updateMedication (Medication medication) async {
    Database db2 = await this.db2;
    final int result = await db2.update(medicationTable, medication.toMap(),
        where: '$colId = ?', whereArgs: [medication.id]);
    return result;
  }

  Future<int> deleteMedication(int? id) async {
    Database db2 = await this.db2;
    final int result =
    await db2.delete(medicationTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

}