import 'package:clock_me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/Database.dart';

class AlarmQuery {
  final TableAlarm = 'alarm';
  Future<int> Insert(String name, String hour, String minutes, String days,
      String status) async {
    final database = await DatabaseService().GetDatabase;
    return await database.rawInsert(
        '''INSERT INTO $TableAlarm (name, hour, minutes, days, status) VALUES (?,?,?,?,?)
''', [name, hour, minutes, days, status]);
  }

  Future<List<AlarmModelData>> Read() async {
    final database = await DatabaseService().GetDatabase;
    final AlarmDatabase = await database.rawQuery('''SELECT * from $TableAlarm 
''');

    List<AlarmModelData> alarmData =
        AlarmDatabase.map((alarm) => AlarmModelData.fromMap(alarm)).toList();
    return alarmData;
  }

  Future<void> Delete(int Id) async {
    final database = await DatabaseService().GetDatabase;
    await database.rawDelete('''DELETE FROM $TableAlarm WHERE id = ?
''', [Id]);
  }

  Future<void> Update(int id, String name, String hour, String minutes,
      String days, String status) async {
    final database = await DatabaseService().GetDatabase;

    await database.rawUpdate('''
    UPDATE $TableAlarm 
    SET name = ?, hour = ?, minutes = ?, days = ?, status = ? 
    WHERE id = ?
  ''', [name, hour, minutes, days, status, id]);
  }
}
