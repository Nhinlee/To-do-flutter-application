import 'package:flutter/cupertino.dart';
import 'package:to_do_app/core/connection/sqlite/sqlite_helper.dart';
import 'package:to_do_app/core/connection/sqlite/table_helper.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getAllTodo();

  Future<void> insert(TodoModel todo);

  Future<void> update(TodoModel todo);

  Future<void> delete(int todoId);
}

class TodoLocalDataSourceImpl extends TodoLocalDataSource {
  final SQLiteHelper helper;

  TodoLocalDataSourceImpl({@required this.helper});

  @override
  Future<List<TodoModel>> getAllTodo() async {
    try {
      // This is fake data for testing
      final rows = await helper.getAll(TodoTableHelper.tableName);
      return rows.length > 0 ? rows.map((e) => TodoModel.fromMap(e)).toList() : [];
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> insert(TodoModel todo) async {
    try {
      await helper.insert(TodoTableHelper.tableName, row: todo.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> update(TodoModel todo) async {
    try {
      await helper.update(
        TodoTableHelper.tableName,
        row: todo.toMap(),
        where: TodoTableHelper.columnId,
        whereArg: todo.id,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> delete(int todoId) async {
    try {
      await helper.delete(TodoTableHelper.tableName,
          where: TodoTableHelper.columnId, whereArg: todoId);
    } catch (e) {
      print(e);
    }
  }
}
