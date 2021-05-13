import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/connection/sqlite/sqlite_helper.dart';
import 'package:to_do_app/feature/data/data_source/local_data_source/todo_local_data_source.dart';
import 'package:to_do_app/feature/data/repository/todo_repository_impl.dart';
import 'package:to_do_app/feature/domain/repository/todo_repository.dart';
import 'package:to_do_app/feature/presentation/provider/todo_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Provider - State management
  sl.registerFactory(() => TodoProvider(repos: sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(localDataSource: sl()),
  );

  // Local data source
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(helper: sl()),
  );

  // SQLite database
  sl.registerLazySingleton(() => SQLiteHelper());
  await sl<SQLiteHelper>().open(SQLiteHelper.todoDB);
}
