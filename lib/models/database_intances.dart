import 'dart:io';

import 'package:note_keeper/models/categories_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseInstances{
  final String _Mydatabase = 'my_database.db';
  final int _DatabaseVersion = 2;

  //Category Table
  final String table1 = 'category';
  final String idCategory = 'idCategory';
  final String name = 'categoryName';
  final String createCategoryAt = 'createAt';
  final String updateCategoryAt = 'updateAt';

  //var Foreign Key for Notes Casual and Notes Logbook
  final String idCategoryFK = 'idCategoryFK';

  //sharing var for Notes Casual and Notes Logbook
  final String reminder = 'reminder';
  final String priority = 'priority';

  //Notes Casual Table
  final String table2 = 'notes';
  final String titleNotes = 'title';
  final String idNotes = 'idNotes';
  final String description = 'description';
  final String createNotesAt = 'createAt';
  final String updateNotesAt = 'updateAt';

  //Notes Logbook Table
  final String table3 = 'notesLogbook';
  final String idNotesLogbook = 'idNotesLogbook';
  final String titleLogbook = 'title';
  final String target = 'target';
  final String lessonLearn = 'lessonLearn';
  final String problem = 'problem';
  final String achievements = 'achievements';
  final String solvingProblem = 'solvingProblem';
  final String createNotesLogbookAt = 'createAt';
  final String updateNotesLogbookAt = 'updateAt';

  Database? _database;
  Future<Database> database() async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _Mydatabase);
    return await openDatabase(path,version: _DatabaseVersion  ,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version)async{
    await db.execute('''
      CREATE TABLE $table1(
        $idCategory INTEGER PRIMARY KEY AUTOINCREMENT,
        $name TEXT NOT NULL,
        $createCategoryAt TEXT NOT NULL,
        $updateCategoryAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $table2(
        $idNotes INTEGER PRIMARY KEY AUTOINCREMENT,
        $titleNotes TEXT NULL,
        $description TEXT NULL,
        $createNotesAt TEXT NOT NULL,
        $updateNotesAt TEXT NOT NULL,
        $reminder TEXT NULL,
        $priority INTEGER NULL,
        $idCategoryFK INTEGER NOT NULL,
        FOREIGN KEY ($idCategoryFK) REFERENCES $table1($idCategory)
      )
    ''');
      
    await db.execute('''
      CREATE TABLE $table3(
        $idNotesLogbook INTEGER PRIMARY KEY AUTOINCREMENT,
        $titleLogbook TEXT NULL,
        $target TEXT NULL,
        $lessonLearn TEXT NULL,
        $problem TEXT NULL,
        $achievements TEXT NULL,
        $solvingProblem TEXT NULL,
        $priority INTEGER NULL,
        $reminder TEXT NULL,
        $createNotesLogbookAt TEXT NOT NULL,
        $updateNotesLogbookAt TEXT NOT NULL,
        $idCategoryFK INTEGER NOT NULL,
        FOREIGN KEY ($idCategoryFK) REFERENCES $table1($idCategory)
      )
    ''');
  }

  Future<List<CategoryModel>> all() async{
    if (_database == null) {
    // throw error atau lakukan penanganan lain jika _database bernilai null
    return [];
    }
    final data = await _database!.query(table1);
    List<CategoryModel> result = 
      data.map((e)=> CategoryModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insertCategory(Map<String, dynamic> row) async{
    final query = await _database!.insert(table1, row);
    return query;
  }
}