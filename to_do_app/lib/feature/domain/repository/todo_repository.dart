import 'package:to_do_app/feature/data/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAllTodo();
  Future<void> insert(TodoModel todo);
  Future<void> update(TodoModel todo);
  Future<void> delete(int todoId);
}