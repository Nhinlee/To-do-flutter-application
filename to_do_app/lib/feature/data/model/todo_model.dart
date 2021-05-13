import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/core/connection/sqlite/table_helper.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  bool isFavorite;

  TodoModel({
    @required this.id,
    @required this.title,
    @required this.description,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[TodoTableHelper.columnId],
      title: map[TodoTableHelper.columnName],
      description: map[TodoTableHelper.columnNote],
      isCompleted: map[TodoTableHelper.columnIsCompleted] == 1,
      isFavorite: map[TodoTableHelper.columnIsFavorite] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TodoTableHelper.columnName: this.title,
      TodoTableHelper.columnNote: this.description,
      TodoTableHelper.columnIsCompleted: this.isCompleted ? 1 : 0,
      TodoTableHelper.columnIsFavorite: this.isFavorite ? 1 : 0,
    };
  }

  @override
  List<Object> get props => [id, title, description];
}
