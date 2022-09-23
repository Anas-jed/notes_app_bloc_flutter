class NotesFields{
  static const String dbName = 'notes.db';
  static const String tableName = 'notes_tb';

  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
  static const String createTimestamp = 'createTimestamp';
  static const String updateTimestamp = 'updateTimestamp';

  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const stringType = 'TEXT';
  static const intTypeNonNull = 'INTEGER NOT NULL';
  static const intType = 'INTEGER';
}