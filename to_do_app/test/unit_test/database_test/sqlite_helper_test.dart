import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';
import 'package:to_do_app/core/connection/sqlite/table_helper.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';

void main() async {
  sqfliteFfiInit();
  group('sqlite test', () {
    test('open sqlite database succeed', () async {
      final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      expect(await db.getVersion(), 0);
      await db.close();
    });

    test('open todo sqlite database succeed', () async {
      final helper = SQLiteHelperTest();
      await helper.open();

      expect(await helper.db.getVersion(), 1);

      await helper.close();
    });

    test('insert todo to database succeed', () async {
      // Open db
      final helper = SQLiteHelperTest();
      await helper.open();
      // Test insert
      final id = await helper.insert(
        TodoTableHelper.tableName,
        row: TodoModel(
          id: 1,
          title: 'abc',
          description: 'abc',
          isCompleted: false,
          isFavorite: true,
        ).toMap(),
      );
      expect(id != null, true);
      // Close db
      await helper.close();
    });

    test('get all todo from db succeed', () async {
      // Open db
      final helper = SQLiteHelperTest();
      await helper.open();
      final rows = await helper.getAll(TodoTableHelper.tableName);
      expect(rows != null, true);
      // Close db
      await helper.close();
    });

    test('delete todo from db succeed', () async {
      // Open db
      final helper = SQLiteHelperTest();
      await helper.open();
      // test delete from db
      final rows = await helper.getAll(TodoTableHelper.tableName);
      final todo = TodoModel.fromMap(rows.last);
      if (rows.length > 0) {
        final rs = await helper.delete(
          TodoTableHelper.tableName,
          where: TodoTableHelper.columnId,
          whereArg: todo.id,
        );
        expect(rs, 1);
      }
      // Close db
      await helper.close();
    });

    test('update todo db succeed', () async {
      // Open db
      final helper = SQLiteHelperTest();
      await helper.open();
      // Test update
      final rows = await helper.getAll(TodoTableHelper.tableName);
      final todo = TodoModel.fromMap(rows.last);
      if (rows.length > 0) {
        final rs = await helper.update(
          TodoTableHelper.tableName,
          row: todo.toMap(),
          where: TodoTableHelper.columnId,
          whereArg: todo.id,
        );
        expect(rs, 1);
      }
      // Close db
      await helper.close();
    });

    test('update all field of todo succeed', () async {
      // Open db
      final helper = SQLiteHelperTest();
      await helper.open();
      // Test update
      final rows = await helper.getAll(TodoTableHelper.tableName);
      final todo = TodoModel.fromMap(rows.last);
      final newTodo = TodoModel(
        id: todo.id,
        title: 'testing',
        description: 'testing',
        isFavorite: !todo.isFavorite,
        isCompleted: !todo.isCompleted,
      );
      if (rows.length > 0) {
        final rs = await helper.update(
          TodoTableHelper.tableName,
          row: newTodo.toMap(),
          where: TodoTableHelper.columnId,
          whereArg: todo.id,
        );
        expect(rs, 1);
      }
      // Close db
      await helper.close();
    });
  });
}

class SQLiteHelperTest {
  static const todoDB = 'todo.db';

  Database db;

  Future<void> open() async {
    try {
      final path = await databaseFactoryFfi.getDatabasesPath();
      db = await databaseFactoryFfi.openDatabase(
        '$path/$todoDB',
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ),
      );
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

  Future<int> insert(String table, {Map<String, dynamic> row}) async {
    return await db.insert(table, row);
  }

  Future<int> update(String table,
      {Map<String, dynamic> row, String where, int whereArg}) async {
    // This is just for table have one primary key! refactor later :))
    return await db.update(table, row, where: '$where = ?', whereArgs: [whereArg]);
  }

  Future<int> delete(String table, {String where, int whereArg}) async {
    return await db.delete(table, where: '$where = ?', whereArgs: [whereArg]);
  }

  Future<void> close() async => db.close();
}
