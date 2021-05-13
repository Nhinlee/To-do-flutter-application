import 'package:flutter/material.dart';
import 'package:to_do_app/feature/presentation/provider/todo_provider.dart';
import 'package:to_do_app/feature/presentation/screen/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AddNewTodoPage extends StatelessWidget {
  static const routeName = 'add-new-todo-page';

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _addNewTodo(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isNotEmpty) {
      todoProvider.addNewTodo(title, description);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD TODO'),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNewTodo(context),
      ),
    );
  }

  Widget getBody() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: AppTheme.paragraphFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: TextStyle(
                  fontSize: AppTheme.paragraphFontSize,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description / Note',
                style: TextStyle(
                  fontSize: AppTheme.paragraphFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: TextStyle(
                  fontSize: AppTheme.paragraphFontSize,
                ),
                maxLines: 10,
              ),
            ],
          ),
        ),
      );
}
