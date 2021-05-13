import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/feature/presentation/provider/todo_provider.dart';
import 'package:to_do_app/feature/presentation/screen/pages/add_new_todo_page.dart';

import 'pages/all_todo_page.dart';
import 'pages/uncompleted_page.dart';
import 'pages/completed_page.dart';
import 'theme/app_theme.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  _onOpenAddNewTodo(BuildContext context) {
    Navigator.of(context).pushNamed(AddNewTodoPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO APP'),
          actions: [
            IconButton(
                icon: Icon(Icons.add_circle_outlined),
                onPressed: () => _onOpenAddNewTodo(context)),
          ],
        ),
        body: getBody(context),
        bottomNavigationBar: Material(
          color: AppTheme.secondary,
          child: TabBar(
            indicator: BoxDecoration(
              color: AppTheme.primary,
            ),
            tabs: [
              getTab('All'),
              getTab('Uncompleted'),
              getTab('Completed'),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) => FutureBuilder(
        future: context.read<TodoProvider>().init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return TabBarView(
            children: [
              AllTodoPage(),
              UncompletedPage(),
              CompletedPage(),
            ],
          );
        },
      );

  Widget getTab(String label) => Tab(
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppTheme.paragraphFontSize,
          ),
        ),
      );
}
