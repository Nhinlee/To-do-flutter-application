import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/core/connection/sqlite/table_helper.dart';

class SQLiteHelper {
  static const todoDB = 'todo.db';

  Database db;

  Future<void> open(String databaseName) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = '$dbPath/$databaseName';
      db = await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    // Executed to create table
    final batch = db.batch();
    _createTodoTable(batch);
    // commit
    await batch.commit();
  }

  void _createTodoTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS ${TodoTableHelper.tableName}');

    // create sql query
    final String todoTableSql = '''create table ${TodoTableHelper.tableName} (
      ${TodoTableHelper.columnId} integer primary key autoincrement, 
      ${TodoTableHelper.columnName} text not null, 
      ${TodoTableHelper.columnNote} text not null, 
      ${TodoTableHelper.columnIsCompleted} integer not null,
      ${TodoTableHelper.columnIsFavorite} integer not null
    )''';
    batch.execute(todoTableSql);
  }

  Future<List<Map>> getAll(String table) async {
    return await db.query(table);
  }

  Future<void> insert(String table, {Map<String, dynamic> row}) async {
    await db.insert(table, row);
  }

  Future<void> update(String table,
      {Map<String, dynamic> row, String where, int whereArg}) async {
    // This is just for table have one primary key! refactor later :))
    await db.update(table, row, where: '$where = ?', whereArgs: [whereArg]);
  }

  Future<int> delete(String table, {String where, int whereArg}) async {
    return await db.delete(table, where: '$where = ?', whereArgs: [whereArg]);
  }

  Future<void> close() async => db.close();
}
