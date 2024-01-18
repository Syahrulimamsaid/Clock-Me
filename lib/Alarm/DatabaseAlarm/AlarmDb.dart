import 'package:sqflite/sqflite.dart';

class AlarmDb {
  final TableAlarm = 'alarm';
  Future<void> createTable(Database Database) async {
    var CekTable = await Database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='alarm'");

    if (CekTable.isEmpty) {
      await Database.execute("""
        CREATE TABLE $TableAlarm (
          id INTEGER PRIMARY KEY,
          name TEXT,
          hour TEXT,
          minutes TEXT,
          days TEXT,
          status TEXT,
          ket TEXT)
""");
    }
  }
}
