import 'package:drift/drift.dart';

part 'database.g.dart';

class Users extends Table {
  TextColumn get uuid => text().withLength(min: 6, max: 32)();

  TextColumn get name => text().withLength(min: 6, max: 32)();

  TextColumn get json => text().named('json')();
}

@DataClassName('Category')
class Workers extends Table {
  TextColumn get uuid => text().withLength(min: 6, max: 32)();

  TextColumn get name => text().withLength(min: 6, max: 32)();

  TextColumn get json => text().named('json')();
}

@DriftDatabase(tables: [Users, Workers])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
