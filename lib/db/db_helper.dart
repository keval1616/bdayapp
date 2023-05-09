import 'package:bdayapp/db/model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBHelper {
  static const int _version = 1;
  static const String _tableName = "birthday";
  static Database? _db;
  static const _columnId = "id";
  static const _columnName = "name";
  static const _columnTime = "time";
  static const _columnDate = "date";
  static const _columnImage = "image";
  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const textType = 'TEXT NOT NULL';
  static Future<void> initDatabase() async {
    if (_db != null) {
      return;
    }
    try {
      final dbPath = await getDatabasesPath();
      String path = join(dbPath, '$_tableName.db');

      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          print("Creating DB");
          return db.execute(
              '''CREATE TABLE $_tableName (${_columnId} $idType,${_columnName} $textType,${_columnTime} $textType,${_columnDate} $textType,${_columnImage} $textType)''');
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print('Error to open DB: ${error.toString()}');
      }
    }
  }

  static Future<int> insert(BirthDayModel birthDayModel) async {
    return await _db?.insert(_tableName, birthDayModel.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>?> query() async {
    return await _db?.query(_tableName);
  }
}
