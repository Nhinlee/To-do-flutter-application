import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';
import 'package:to_do_app/feature/presentation/screen/theme/app_theme.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(int todoId) tapCheckBoxCallback;
  final Function(int todoId) tapDeleteCallback;
  final Function(int todoId) tapFavoriteCallback;

  const TodoItem({
    Key key,
    @required this.todo,
    this.tapCheckBoxCallback,
    this.tapDeleteCallback,
    this.tapFavoriteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          this.tapDeleteCallback(this.todo.id);
        }
      },
      child: Container(
        width: size.width,
        height: 60,
        margin: EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: AppTheme.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 16),
                getCheckBox(),
                const SizedBox(width: 16),
                Text(
                  this.todo.title,
                  style: TextStyle(fontSize: AppTheme.paragraphFontSize),
                )
              ],
            ),
            IconButton(
              icon: Icon(
                todo.isFavorite ? Icons.star : Icons.star_border,
                color: todo.isFavorite ? AppTheme.primary : AppTheme.secondary,
              ),
              onPressed: () => tapFavoriteCallback(todo.id),
            )
          ],
        ),
      ),
    );
  }

  Widget getCheckBox() => InkWell(
        onTap: () => this.tapCheckBoxCallback(this.todo.id),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primary,
              width: 1.0,
            ),
            color: this.todo.isCompleted ? AppTheme.primary : AppTheme.white,
          ),
          child: this.todo.isCompleted
              ? Icon(
                  Icons.check,
                  color: AppTheme.white,
                  size: 16,
                )
              : Container(),
        ),
      );
}
