import 'package:drift/web.dart';

import '../database.dart';

Database createDatabase({bool logStatements = false}) {
//  return Database(WebDatabase('db', logStatements: logStatements));
  return Database(
      WebDatabase.withStorage(DriftWebStorage.indexedDb("database")));
}
