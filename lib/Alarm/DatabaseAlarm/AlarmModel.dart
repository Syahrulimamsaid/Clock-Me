class AlarmModelData {
  int id;
  String name;
  String hour;
  String minutes;
  String days;
  String status;
  String ket;

  AlarmModelData(
      {required this.id,
      required this.name,
      required this.hour,
      required this.minutes,
      required this.days,
      required this.status,
      required this.ket});

  factory AlarmModelData.fromMap(Map<String, dynamic> map) {
    return AlarmModelData(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        hour: map['hour'] ?? '',
        minutes: map['minutes'] ?? '',
        days: map['days'] ?? '',
        status: map['status'] ?? '',
        ket: map['ket'] ?? '');
  }
}
