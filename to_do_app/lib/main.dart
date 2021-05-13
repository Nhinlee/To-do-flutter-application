import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/feature/presentation/provider/todo_provider.dart';
import 'package:to_do_app/feature/presentation/screen/pages/add_new_todo_page.dart';
import 'package:to_do_app/injection_container.dart' as ic;
import 'feature/presentation/screen/root_page.dart';
import 'feature/presentation/screen/theme/app_theme.dart';
import 'injection_container.dart';

void main() async {
  // Widget Binding
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency Injection
  await ic.init();
  // Run App
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<TodoProvider>(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: AppTheme.primary,
        ),
        home: RootPage(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AddNewTodoPage.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => AddNewTodoPage(),
          );
        }
    }
    return null;
  }
}
