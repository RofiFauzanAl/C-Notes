import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class CreateDatabase{
  static Future<void> createTablesCategory(sql.Database database) async{
    await database.execute('''
      CREATE TABLE category_notes(
        id_category INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name_category TEXT NOT NULL,
        createCategoryAt TEXT NOT NULL
      )
    ''');
  }

  static Future<void> createTablesNotes(sql.Database database) async{
    await database.execute('''
      CREATE TABLE notes(
        id_note INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL,
        content_note TEXT,
        type DEFAULT 'Notes',
        priority INTEGER NOT NULL,
        createNoteAt TEXT NOT NULL,
        id_category INTEGER NOT NULL,
        FOREIGN KEY(id_category) REFERENCES category_notes(id_category)
      )
    ''');
  }

  static Future<void> createLogbook(sql.Database database) async{
    await database.execute('''
      CREATE TABLE logbooks(
        id_logbook INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NULL,
        target TEXT,
        lesson_learn TEXT,
        problem TEXT,
        achievements TEXT,
        solving_problem TEXT NULL,
        priority INTEGER NOT NULL,
        reminder TEXT,
        create_notes_logbook_at TEXT NOT NULL,
        type DEFAULT 'Logbook',
        id_category INTEGER NOT NULL,
        FOREIGN KEY(id_category) REFERENCES category_notes(id_category)
      )
    ''');
  }
  
  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'myDatabase.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTablesCategory(database);
        await createTablesNotes(database);
        await createLogbook(database);  
      }
    );
  }

  // CreateDatabase._privateConstructor();
  // static final CreateDatabase instance =
  //     CreateDatabase._privateConstructor();

  // static sql.Database? _database;
  // Future<sql.Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await _initDatabase();
  //   return _database!;
  // }

  // _initDatabase() async {
  //   Directory? documentsDirectory = await getApplicationDocumentsDirectory();
  //   // ignore: unnecessary_null_comparison
  //   if (documentsDirectory == null) {
  //     throw Exception("Failed to get application documents directory");
  //   }
  //   String path = join(documentsDirectory.path, 'myDatabase.db');
  //   return await sql.openDatabase(path, version: 1,
  //       onCreate: (sql.Database db, int version) async {
  //     await createTablesCategory(db);
  //     await createTablesNotes(db);
  //     await createLogbook(db);
  //   });
  // }
  
  Future<List<Map<String, dynamic>>> queryAllCategory() async {
    sql.Database db = await CreateDatabase.db();
    return await db.query('category_notes', orderBy: "id_category");
  }

  //Create Category Notes
  static Future<int> createCategory(String title, String dateNow) async {
    final db = await CreateDatabase.db();
    final data = {
      'name_category': title,
      'createCategoryAt': dateNow
    };
    final id = await db.insert('category_notes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateCategory(int id, String title, String dateNow) async {
    final db = await CreateDatabase.db();
    final data = {
      'id_category': id,
      'name_category': title,
      'createCategoryAt': dateNow
    };

    final result = await db.update('category_notes', data, where: "id_category = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteCategory(int id) async {
    final db = await CreateDatabase.db();
    try {
      await db.delete("category_notes", where: "id_category = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}