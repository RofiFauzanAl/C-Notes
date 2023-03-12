import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:class_notes/models/create_database.dart';


class createNotes{
  
  Future<List<Map<String, dynamic>>> queryAllNotes() async {
    sql.Database db = await CreateDatabase.db();
    return await db.query('notes', orderBy: "id_note");
  }

  //Create Category Notes
  static Future<int> createNote(String title, String content, int priority, String dateNow, int idCategory) async {
    final db = await CreateDatabase.db();
    final data = {
      'title': title,
      'content': content,
      'type': 'Notes',
      'priority': priority,
      'createNoteAt': dateNow,
      'id_category': idCategory,
    };
    final id = await db.insert('notes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //update Notes
  static Future<int> updateNote(int id, String title, String content, int priority, String dateNow) async {
    final db = await CreateDatabase.db();
    final data = {
      'title': title,
      'content': content,
      'priority': priority,
    };
    final result = await db.update('notes', data, where: "id_note = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteNote(int id) async {
    final db = await CreateDatabase.db();
    try {
      await db.delete("notes", where: "id_note = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an note: $err");
    }
  }
}