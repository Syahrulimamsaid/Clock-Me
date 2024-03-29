
import 'package:Clock_Me/Alarm/AddAlarm.dart';
import 'package:Clock_Me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:Clock_Me/Alarm/Model/AlarmEventModel.dart';
import 'package:Clock_Me/Alarm/Model/PopUpDelete.dart';
import 'package:Clock_Me/Alarm/Query/AlarmQuery.dart';
import 'package:Clock_Me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 8, 44),
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
                          return AlarmEvent(
                            ID: data.id,
                            Title: data.name,
                            Days: data.days,
                            Hour: data.hour,
                            Minutes: data.minutes,
                            Status: data.status,
                            Ket: data.ket,
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
                              _handleRefresh();
                            },
                            OnLongPress: () async {
                              await Navigator.of(context)
                                  .push(MunculPage(PopUpDelete(
                                Title: data.name,
                                Id: data.id,
                              )));
                              _handleRefresh();
                            },
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
              style:  const TextStyle(
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
}
