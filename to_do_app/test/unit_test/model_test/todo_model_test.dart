import 'package:test/test.dart';
import 'package:to_do_app/core/connection/sqlite/table_helper.dart';
import 'package:to_do_app/feature/data/model/todo_model.dart';

void main() {
  group('todo model test', () {
    test('from map', () {
      final Map<String, dynamic> map = {
        TodoTableHelper.columnId: 1,
        TodoTableHelper.columnName: 'abc',
        TodoTableHelper.columnNote: 'abc',
      };

      expect(
          TodoModel.fromMap(map),
          TodoModel(
            id: 1,
            title: 'abc',
            description: 'abc',
          ));
    });

    test('to map', () {
      final todo = TodoModel(
        id: 1,
        title: 'abc',
        description: 'abc',
      );
      expect({
        TodoTableHelper.columnName: 'abc',
        TodoTableHelper.columnNote: 'abc',
        TodoTableHelper.columnIsCompleted: 0,
        TodoTableHelper.columnIsFavorite: 0,
      }, todo.toMap());
    });
  });
}
