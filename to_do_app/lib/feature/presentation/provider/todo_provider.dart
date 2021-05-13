import 'package:flutter/cupertino.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';
import 'package:to_do_app/feature/domain/repository/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository repos;

  TodoProvider({@required this.repos});

  // This is cached todos when app run
  List<TodoModel> todos;

  Future<void> init() async {
    todos = await repos.getAllTodo();
  }

  List<TodoModel> get allTodo => todos;

  List<TodoModel> get unCompletedTodo =>
      todos.where((todo) => todo.isCompleted == false).toList();

  List<TodoModel> get completedTodo =>
      todos.where((todo) => todo.isCompleted == true).toList();

  void addNewTodo(String title, String description) {
    // get id and todoModel
    final id = todos.length > 0 ? todos.last.id + 1 : 0;
    final todo = TodoModel(id: id, title: title, description: description);
    // Push to db
    repos.insert(todo);
    // Push to ui
    todos.add(todo);
    notifyListeners();
  }

  void switchCompletedStatus(int todoId) {
    final todo = todos.firstWhere((element) => element.id == todoId);
    todo.isCompleted = !todo.isCompleted;
    // Push to db
    repos.update(todo);
    //
    notifyListeners();
  }

  void deleteTodo(int todoId) {
    // Push to db
    repos.delete(todoId);
    // UI
    todos.removeWhere((todo) => todo.id == todoId);
    notifyListeners();
  }

  void switchFavoriteStatus(int todoId) {
    final todo = todos.firstWhere((element) => element.id == todoId);
    todo.isFavorite = !todo.isFavorite;
    // Push to db
    repos.update(todo);
    //
    notifyListeners();
  }
}
