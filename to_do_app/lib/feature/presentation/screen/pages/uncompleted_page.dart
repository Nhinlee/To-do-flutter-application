import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/feature/presentation/provider/todo_provider.dart';
import 'package:to_do_app/feature/presentation/screen/widgets/todo_item.dart';

import 'generic/todo_skeleton_page.dart';

class UncompletedPage extends StatelessWidget {
  const UncompletedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoSkeletonPage(
      title: 'TODO > Uncompleted',
      listviewWidget: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final todos = todoProvider.unCompletedTodo;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoItem(
              todo: todos[index],
              tapCheckBoxCallback: (todoId) => todoProvider.switchCompletedStatus(todoId),
              tapDeleteCallback: (todoId) => todoProvider.deleteTodo(todoId),
              tapFavoriteCallback: (todoId) => todoProvider.switchFavoriteStatus(todoId),
            ),
          );
        },
      ),
    );
  }
}
