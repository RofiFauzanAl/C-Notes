import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:class_notes/models/create_database.dart';

class createLogbooks{
  
  Future<List<Map<String, dynamic>>> queryAllLogbook() async {
    sql.Database db = await CreateDatabase.db();
    return await db.query('logbooks', orderBy: "id_logbook");
  }

  //Create Logbook
  static Future<int> createLogbook(int idCategory ,String title, String target, String lessonLearn, String problem, String achievements, String problemSolving, int priority, String reminder, String dateNow) async {
    final db = await CreateDatabase.db();
    final data = {
      'title': title,
      'target': target,
      'lesson_learn': lessonLearn,
      'problem': problem,
      'achievements': achievements,
      'solving_problem': problemSolving,
      'type': 'Logbook',
      'priority': priority,
      'reminder': reminder,
      'create_notes_logbook_at': dateNow,
      'id_category': idCategory,
    };
    final id = await db.insert('logbooks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // update Logbook
  static Future<int> updateLogbook(int id, String title, String target, String lessonLearn, String problem, String achievements, String problemSolving, int priority, String reminder, String dateNow) async {
    final db = await CreateDatabase.db();
    final data = {
      'title': title,
      'target': target,
      'lesson_learn': lessonLearn,
      'problem': problem,
      'achievements': achievements,
      'solving_problem': problemSolving,
      'priority': priority,
      'reminder': reminder,
    };
    final result = await db.update('logbooks', data, where: "id_logbook = ?", whereArgs: [id]);
    return result;
  }

  //Delete Logbook
  static Future<int> deleteLogbook(int id) async {
    final db = await CreateDatabase.db();
    final result = await db.delete('logbooks', where: "id_logbook = ?", whereArgs: [id]);
    return result;
  }
}