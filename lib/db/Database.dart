import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_counter/dto/CounterElement.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/counterDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE counter ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "value INTEGER"
          ")");
    });
  }

  Future<List<CounterElement>> getAll() async {
    final db = await database;
    List<CounterElement> countList = [];
    List<Map<String, dynamic>> list =
        await db.rawQuery("SELECT * FROM counter ORDER BY id ASC");
    list.forEach((e) {
      CounterElement ce = CounterElement.parse(e);
      countList.add(ce);
    });
    return countList;
  }

  void insertElement(CounterElement ce) async {
    final db = await database;
    await db.rawInsert("INSERT INTO Counter (name, value)"
        " VALUES ('${ce.name}',${ce.value})");
  }

  void updateElement(CounterElement ce) async {
    final db = await database;
    await db.rawUpdate(
        "UPDATE Counter SET name = '${ce.name}', value = ${ce.value} WHERE id = ${ce.id}");
  }

  void deleteElement(CounterElement ce) async {
    final db = await database;
    await db.rawDelete("DELETE FROM Counter WHERE id = ${ce.id}");
  }
}
