import 'package:flutter/cupertino.dart';
import 'package:to_do_app/feature/data/data_source/local_data_source/todo_local_data_source.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';
import 'package:to_do_app/feature/domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({@required this.localDataSource});

  @override
  Future<List<TodoModel>> getAllTodo() async {
    // TODO: check network before (if have api :)) )
    return await localDataSource.getAllTodo();
  }

  @override
  Future<void> insert(TodoModel todo) async {
    // TODO: check network before (if have api :)) )
    await localDataSource.insert(todo);
  }

  @override
  Future<void> update(TodoModel todo) async {
    // TODO: check network before (if have api :)) )
    await localDataSource.update(todo);
  }

  @override
  Future<void> delete(int todoId) async {
    // TODO: check network before (if have api :)) )
    await localDataSource.delete(todoId);
  }
}
