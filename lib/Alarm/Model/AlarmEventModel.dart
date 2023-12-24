import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clock_me/Alarm/DetailAlarm.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:clock_me/Notification/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

class AlarmEvent extends StatefulWidget {
  final String Title;
  final int ID;
  final String Hour;
  final String Days;
  final String Minutes;
  final String Status;
  // bool isSwitched;
  final VoidCallback OnTap;
  final VoidCallback OnLongPress;

  AlarmEvent({
    required this.Title,
    required this.Days,
    required this.Hour,
    required this.ID,
    required this.Minutes,
    required this.Status,
    required this.OnTap,
    required this.OnLongPress,
    // required this.isSwitched
  });

  // void ToggleSwitch() {
  //   isSwitched = !isSwitched;
  // }

  @override
  State<AlarmEvent> createState() => _AlarmEventState();
}

class _AlarmEventState extends State<AlarmEvent> {
  final AlarmQueryExecute = AlarmQuery();
  String day = '';

  String sun = '';
  String mon = '';
  String tue = '';
  String wed = '';
  String thu = '';
  String fri = '';
  String sat = '';

  bool isSwitched = false;

  void UpdateData(int id, String name, String hour, String minutes, String days,
      String status) async {
    try {
      final UpdateData =
          await AlarmQueryExecute.Update(id, name, hour, minutes, days, status);
      // print('berhasil');
    } catch (e) {
      print("gagal");
    }
  }

  bool isDateFormat(String input, String format) {
    try {
      DateTime? parsedDateTime = DateTime.tryParse(input);

      if (parsedDateTime != null) {
        print('Format tanggal sesuai: $input sesuai dengan pola $format');
        return true;
      } else {
        print(
            'Format tanggal tidak sesuai: $input tidak sesuai dengan pola $format');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  void ChangeDate() {
    setState(() {
      if (isDateFormat(widget.Days, 'yyyy-MM-dd')) {
        day = 'Tomorrow-' + FormatDate(DateTime.parse(widget.Days));
      } else if (widget.Days == 'Every Day') {
        day = widget.Days;
      } else {
        List<String> hariView = widget.Days.split(' ');
        for (String namaHari in hariView) {
          (namaHari == "Sun")
              ? sun = 'Sun'
              : (namaHari == "Mon")
                  ? mon = 'Mon'
                  : (namaHari == "Tue")
                      ? tue = 'Tue'
                      : (namaHari == "Wed")
                          ? wed = 'Wed'
                          : (namaHari == "Thu")
                              ? thu = 'Thu'
                              : (namaHari == "Fri")
                                  ? fri = 'Fri'
                                  : sat = 'Sat';
          print("$namaHari = nama hari");
        }
        day = "Every ${hariView.join(', ')}";
      }
    });
  }

  void DateStatus() {
    setState(() {
      if (isDateFormat(widget.Days, 'yyyy-MM-dd')) {
        DateTime dateFromData =
            DateTime.parse('${widget.Days} ${widget.Hour}:${widget.Minutes}');
        DateTime DateNow = DateTime.parse(
            DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
        if (dateFromData.isAfter(DateNow)) {
          isSwitched = true;
        } else {
          isSwitched = false;
        }
      } else {
        isSwitched = true;
      }
    });
  }

  void DateSet() async {
    if (isSwitched == true) {
      if (isDateFormat(widget.Days, 'yyyy-MM-dd')) {
        var Merge = '${widget.Days} ${widget.Hour}:${widget.Minutes}';

        Duration JadwalAlarm = DateTime.parse(Merge).difference(DateTime.now());

        // await Workmanager().registerOneOffTask(
        //     widget.ID.toString(), widget.Title,
        //     initialDelay: JadwalAlarm);

        NotificationService.showNotification(widget.ID,
            Title: widget.Title,
            Body: '${widget.Hour} : ${widget.Minutes}',
            notificationLayout: NotificationLayout.BigText,
            category: NotificationCategory.Alarm,
            schedule: Schedule(
                details: widget.Title, time: DateTime.now().add(JadwalAlarm)),
            actionButtons: [
              NotificationActionButton(
                  key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
            ]);

        print('tanggal');
      } else {
        if (widget.Days == "Every Day") {
          DateTime now = DateTime.now();
          DateTime scheduledTime = DateTime(now.year, now.month, now.day,
              int.parse(widget.Hour), int.parse(widget.Minutes));

          if (now.isAfter(scheduledTime)) {
            scheduledTime = scheduledTime.add(Duration(days: 1));
          }
          Duration JadwalSetiapHari = DateTime.parse(scheduledTime.toString())
              .difference(DateTime.now());

          NotificationService.showNotification(widget.ID,
              Title: widget.Title,
              Body: '${widget.Hour} : ${widget.Minutes}',
              notificationLayout: NotificationLayout.BigText,
              category: NotificationCategory.Alarm,
              schedule: Schedule(
                  details: widget.Title,
                  time: DateTime.now().add(JadwalSetiapHari)),
              actionButtons: [
                NotificationActionButton(
                    key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
              ]);

          print('Setiap Hari');
        } else {
          if (sun.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Sun') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Sun');
            }
          } else if (mon.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Mon') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Mon');
            }
          } else if (tue.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Tue') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Tue');
            }
          } else if (wed.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Wed') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Wed');
            }
          } else if (thu.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Thu') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Thu');
            }
          } else if (fri.isNotEmpty) {
            if (DateFormat("EEE").format(DateTime.now()) == 'Fri') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Fri');
            }
          } else {
            if (DateFormat("EEE").format(DateTime.now()) == 'Sat') {
              String tanggalSekarang =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var Merge = '$tanggalSekarang ${widget.Hour}:${widget.Minutes}';

              Duration JadwalAlarm =
                  DateTime.parse(Merge).difference(DateTime.now());

              NotificationService.showNotification(widget.ID,
                  Title: widget.Title,
                  Body: '${widget.Hour} : ${widget.Minutes}',
                  notificationLayout: NotificationLayout.BigText,
                  category: NotificationCategory.Alarm,
                  schedule: Schedule(
                      details: widget.Title,
                      time: DateTime.now().add(JadwalAlarm)),
                  actionButtons: [
                    NotificationActionButton(
                        key: 'Dismiss', label: 'Dismiss', autoDismissible: true)
                  ]);

              print('ya Sat');
            }
          }
          print('Tidak Setiap Hari');
        }
        print('tidak Tanggal');
      }

      print('y');
    } else {
      print('n');
    }
  }

  String FormatDate(DateTime date) {
    return DateFormat('EEEE, MMM dd, yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    DateStatus();
    DateSet();
    ChangeDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
        // padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 23, 33, 78),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.18,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.OnTap,
            onLongPress: widget.OnLongPress,
            borderRadius: BorderRadius.circular(25),
            splashColor: Color.fromARGB(255, 0, 8, 44),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.tags,
                              color: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                widget.Title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.3,
                          child: Switch(
                            activeTrackColor: Color.fromARGB(255, 247, 230, 2),
                            activeColor:
                                const Color.fromARGB(255, 243, 243, 243),
                            value: isSwitched,
                            onChanged: (value) async {
                              setState(() {
                                isSwitched = value;
                                UpdateData(
                                    widget.ID,
                                    widget.Title,
                                    widget.Hour,
                                    widget.Minutes,
                                    widget.Days,
                                    (value == true) ? 'On' : 'Off');
                              });
                              DateSet();
                              // DateStatus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.Hour + ' : ' + widget.Minutes,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 241, 38),
                                fontSize: 30),
                          ),
                          Text(
                            day,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 243, 243, 243),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
