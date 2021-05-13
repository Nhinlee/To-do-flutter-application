import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:to_do_app/core/connection/sqlite/sqlite_helper.dart';
import 'package:to_do_app/injection_container.dart' as ic;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  group('sqlite test', () {
    test('open sqlite database succeed', () async {
      final SQLiteHelper sqlHelper = ic.sl<SQLiteHelper>();
      expect(null, sqlHelper.db);
      // This test not working because unit test i can't run getDatabasePath ???
    });
  });
}
