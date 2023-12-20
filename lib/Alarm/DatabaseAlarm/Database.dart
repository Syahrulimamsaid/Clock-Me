import 'package:clock_me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _Database;

  Future<Database> get GetDatabase async {
    if (_Database != null) {
      return _Database!;
    } else {
      _Database = await _initialize();
      return _Database!;
    }
  }

  Future<String> get FullPath async {
    const Name = 'clockMe.db';
    final path = await getDatabasesPath();
    return join(path, Name);
  }

  Future<Database> _initialize() async {
    final Path = await FullPath;
    var database = await openDatabase(Path,
        version: 1, onCreate: Create, singleInstance: true);
    return database;
  }

  Future<void> Create(Database database, int version) async =>
      await AlarmDb().createTable(database);
}
