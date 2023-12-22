import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clock_me/Alarm/AddAlarm.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/Database.dart';
import 'package:clock_me/Alarm/DetailAlarm.dart';
import 'package:clock_me/Alarm/Model/AlarmEventModel.dart';
import 'package:clock_me/Alarm/Model/PopUpDelete.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

class AlarmPage extends StatefulWidget {
  // final String? Status;
  const AlarmPage({
    // required this.Status,
    super.key,
  });

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool isSwitched = false;
  bool Switch = false;
  List<AlarmModelData> alarmDataList = [];
  final AlarmDatabase = AlarmQuery();

  Future<List<AlarmModelData>>? ReadData = null;

  @override
  void initState() {
    super.initState();
    ReadData = AlarmQuery().Read();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 0.0.toInt()));

    setState(() {
      ReadData = AlarmQuery().Read();
    });
  }

  Route<dynamic> MunculPage(Widget pages) {
    return PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return pages;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 0.5); // Mulai dari posisi bawah layar
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Animasi opacity saat halaman muncul
        var opacityAnimation = animation.drive(Tween<double>(begin: 0, end: 1));

        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.translate(
            offset: offsetAnimation.value,
            child: child,
          ),
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
        child: Column(
          children: [
            const TitlePageModel(Title: "Alarm"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.73,
              child: Center(
                child: FutureBuilder<List<AlarmModelData>>(
                  future: ReadData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return ErrorView(context,
                          Tulisan: snapshot.error.toString(),
                          icon: FontAwesomeIcons.exclamation);
                    } else if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.map((data) {
                          if (isDateFormat(data.days, 'yyyy-MM-dd')) {
                            DateTime dateFromData = DateTime.parse(
                                '${data.days} ${data.hour}:${data.minutes}');
                            DateTime DateNow = DateTime.parse(
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(DateTime.now()));
                            if (dateFromData.isAfter(DateNow)) {
                              isSwitched = true;
                            } else {
                              isSwitched = false;
                            }
                          } else {
                            isSwitched = true;
                          }

                          return AlarmEvent(
                            ID: data.id,
                            Title: data.name,
                            Days: data.days,
                            Hour: data.hour,
                            Minutes: data.minutes,
                            Status: data.status,
                            OnTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAlarmPage(
                                          StatusAdd: false,
                                          Id: data.id,
                                          Title: data.name,
                                          Days: data.days,
                                          Hours: int.parse(data.hour),
                                          Minutes: int.parse(data.minutes),
                                        )),
                              );
                            },
                            OnLongPress: () async {
                              await Navigator.of(context)
                                  .push(MunculPage(PopUpDelete(
                                Title: data.name,
                                Id: data.id,
                              )));
                              _handleRefresh();
                            },
                            isSwitched: (isSwitched)
                                ? (data.status == 'On')
                                    ? true
                                    : false
                                : false,
                          );
                        }).toList(),
                      );
                    } else {
                      return ErrorView(context,
                          Tulisan: 'Event Tidak Ada',
                          icon: FontAwesomeIcons.faceSadTear);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center ErrorView(BuildContext context,
      {required String Tulisan, required IconData icon}) {
    return Center(
        child: Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              Tulisan,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ));
  }

  void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print(
        "[$now] Hello, world! YAYAYAYAYAYAYAYA isolate=${isolateId} function='$printHello'");
  }
}
