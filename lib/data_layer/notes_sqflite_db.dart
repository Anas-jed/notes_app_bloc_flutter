import 'dart:developer';

import 'package:notes_app/data_layer/notes_fields.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb(NotesFields.dbName);
    return _database!;
  }

  _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, singleInstance: true, onCreate: _createDB);
  }

  Future<void> _createDB(Database database, int version) async {
    database.execute('''
    CREATE TABLE ${NotesFields.tableName} (
    ${NotesFields.id} ${NotesFields.idType},
    ${NotesFields.title} ${NotesFields.stringType},
    ${NotesFields.content} ${NotesFields.stringType},
    ${NotesFields.createTimestamp} ${NotesFields.intTypeNonNull},
    ${NotesFields.updateTimestamp} ${NotesFields.intTypeNonNull} 
    )
    ''');
  }

  Future<int> insertNote(Map<String, dynamic> map) async {
    final db = await instance.database;
    final v =  await db.insert(NotesFields.tableName, map);
    log('v: $v');
    return v;
  }

  Future<int> updateNote(Map<String, dynamic> map) async {
    final db = await instance.database;

    return await db.update(NotesFields.tableName, map,
        where: '${NotesFields.id} = ?', whereArgs: [map['_id']]);
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(NotesFields.tableName);
    return maps;
  }

  Future<Map<String, dynamic>?> getNote(String id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> map = await db.query(NotesFields.tableName,
        where: '${NotesFields.id} = ?', whereArgs: [id]);
    return map.length > 0 ? map.first : null;
  }

  Future<void> deleteNote(int id) async {
    final db = await instance.database;
    await db.delete(NotesFields.tableName,
        where: '${NotesFields.id} = ?', whereArgs: [id]);
  }

  Future close() async => await instance.database
    ..close();
}
