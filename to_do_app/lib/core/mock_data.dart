import 'package:to_do_app/feature/data/model/todo_model.dart';

class FakeData {
  static int nextId = 0;
  static List<TodoModel> todos = [
    TodoModel(
      id: nextId++,
      title: 'Algorithm & Data Structure',
      description: 'This is my important todo right now',
    ),
    TodoModel(
      id: nextId++,
      title: 'TODO',
      description: 'just for testing purpose :))',
    ),
    TodoModel(
      id: nextId++,
      title: 'Make Prototype',
      description: 'On figma',
    ),
    TodoModel(
      id: nextId++,
      title: 'Algorithm & Data Structure',
      description: 'This is my important todo right now',
    ),
    TodoModel(
      id: nextId++,
      title: 'Implement Main Feature',
      description: 'this my final project!',
    ),
    TodoModel(
      id: nextId++,
      title: 'Android dev',
      description: 'This is my job in future',
    ),
  ];
}
