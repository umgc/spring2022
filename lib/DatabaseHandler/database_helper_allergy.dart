import 'dart:async';
import 'dart:io';
import 'package:memorez/Model/Allergy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorez/Model/MedicationModel.dart';
import 'package:memorez/Model/Medical.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _db3;

  String allergyTable = 'allergy_table';
  String allergyTable_colID = 'id';
  String colAllergy = 'allergy';
  String colReaction = 'reaction';
  String colStatus = 'status';
  Future<Database> get db3 async {
    _db3 = await _initDb();
    return _db3;
  }
  
  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'memorez.db3';

    final medicationListDb =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return medicationListDb;
  }


  void _createDb(Database db3, int version) async {
    await db3.execute(
        'CREATE TABLE $allergyTable ($allergyTable_colID INTEGER PRIMARY KEY AUTOINCREMENT,$colAllergy TEXT, $colReaction TEXT, $colStatus INTEGER)');
         }

  // this is the getMap List

  //good to go, values are returned
  Future<List<Map<String, dynamic>>> getMapAllergyList() async {
    Database db3 = await this.db3;
    final List<Map<String, dynamic>> result = await db3.query(allergyTable);
    return result;
  }

  //Get List

  Future<List<Allergy>> getAllergyList() async {

    final List<Map<String, dynamic>> _allergyMapList = await getMapAllergyList();
    final List<Allergy> _allergyList = [];
    _allergyMapList.forEach((allergyMap) {
      _allergyList.add(Allergy.fromMap(allergyMap));
    });
    return _allergyList;
  }

  //Insert

  Future<int> insertAllergy(Allergy allergy) async {
    Database db3 = await this.db3;
    final int result = await db3.insert(allergyTable, allergy.toMap());
    return result;
  }

  //Update

  Future<int> updateAllergy (Allergy allergy) async {
    Database db3 = await this.db3;
    final int result = await db3.update(allergyTable, allergy.toMap(),
        where: '$allergyTable_colID = ?', whereArgs: [allergy.id]);
    return result;
  }

  //Delete

  Future<int> deleteAllergy(int? id) async {
    Database db3 = await this.db3;
    final int result =
    await db3.delete(allergyTable, where: '$allergyTable_colID = ?', whereArgs: [id]);
    return result;
  }













}