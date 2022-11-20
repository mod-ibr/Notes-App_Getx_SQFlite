import 'dart:async';
import 'dart:io';

import 'package:notes_app_getx_sqflite/model/Note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // singlotone Class constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  final _dbName = "notes.db";
  final _dbVersion = 1;
  final _tableName = "notes";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        dateTimeEdited TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
      ''');
  }

  // Add Note
  Future<int> addNote(Note note) async {
    Database db = await instance.database;
    return await db.insert(_tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Delete All Notes
  Future<int> deleteAllNotes() async {
    Database db = await instance.database;
    int rows = await db.delete(_tableName);
    print('================================');
    print('NOTE DELETED from Handeller');
    print('================================');
    return rows;
  }

  // Update Note
  Future<int> updateNote(Note note) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  // Get All Notes
  Future<List<Note>> getNoteList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> allData = await db.query(_tableName);
    if (allData.isNotEmpty) {
      return allData.map((note) => Note.fromMap(note)).toList();
    } else {
      return [];
    }
  }
}
