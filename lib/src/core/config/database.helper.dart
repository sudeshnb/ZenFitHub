import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

class DatabaseHelper {
  static const _databaseName = "Offline.db";
  static const _databaseVersion = 1;

  static const table = 'user_table';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static late Database _database;
  Future<Database> get database async {
    // return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id TEXT PRIMARY KEY,
            image TEXT NULL,
            name TEXT NULL,
            email TEXT NULL,
            phone TEXT NULL,
            age INT NULL,
            gender TEXT NULL,
            height TEXT NULL,
            weight TEXT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //Get all records which are unsynched
  Future<UserModel?> getUser() async {
    Database db = await instance.database;
    final list = await db.rawQuery('SELECT * FROM $table ');
    if (list.isEmpty) return null;
    return UserModel.fromMap(list.first);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(UserModel user) async {
    Database db = await instance.database;
    return await db.update(table, user.toMap());
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
