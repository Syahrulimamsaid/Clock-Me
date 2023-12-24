import 'package:clock_me/Alarm/AddAlarm.dart';
import 'package:clock_me/Alarm/Alarm.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/Database.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:clock_me/Clock/Clock.dart';
import 'package:clock_me/PageBlank.dart';
import 'package:clock_me/Stopwatch/Stopwatch.dart';
import 'package:clock_me/Timer/Timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<AlarmModelData>> ReadData;
  final AlarmDatabase = AlarmDb();

  int SelectIndex = 0;
  String StatusRefAlarm = 'NO';

  void RunDatabase() {
    final database = DatabaseService().GetDatabase;
    database.then((db) async {
      await AlarmDatabase.createTable(db);
    }).catchError((error) {
      print("Error initializing database: $error");
      // Handle error as needed
    });
  }

  @override
  void initState() {
    super.initState();
    RunDatabase();
    ReadData = AlarmQuery().Read();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> PageApp = [
      AlarmPage(
      ),
      ClockPage(),
      StopwatchPage(),
      TimerPage(),
      PageBlank()
    ];

    return Scaffold(
      body: PageApp[SelectIndex],
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (SelectIndex != 0) {
              SelectIndex = 0;
            } else {
              SelectIndex = 4;
              ToAdd();
            }
          });
        },
        child: Icon((SelectIndex != 0) ? Icons.home : Icons.add),
        backgroundColor: Color.fromARGB(255, 247, 230, 2),
        foregroundColor: Color.fromARGB(255, 0, 8, 44),
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        shape: CircularNotchedRectangle(),
        color: Color.fromARGB(255, 23, 33, 78),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            SelectIndex = 0;
                          });
                        },
                        child: Menu(
                          Icons.alarm,
                          (SelectIndex == 0 || SelectIndex == 4)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                          "Alarm",
                          (SelectIndex == 0 || SelectIndex == 4)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            SelectIndex = 1;
                          });
                        },
                        child: Menu(
                          Icons.access_time,
                          (SelectIndex == 1)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                          "Clock",
                          (SelectIndex == 1)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            SelectIndex = 2;
                          });
                        },
                        child: Menu(
                          Icons.timer_outlined,
                          (SelectIndex == 2)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                          "Stopwatch",
                          (SelectIndex == 2)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            SelectIndex = 3;
                          });
                        },
                        child: Menu(
                          Icons.hourglass_bottom_outlined,
                          (SelectIndex == 3)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                          "Timer",
                          (SelectIndex == 3)
                              ? Color.fromARGB(255, 247, 230, 2)
                              : const Color.fromARGB(255, 243, 243, 243),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void ToAdd() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddAlarmPage(StatusAdd: true,)));
    setState(() {
      SelectIndex = 0;
      print('Yes');
    });
  }

  Container Menu(
    IconData iconData,
    Color Warna,
    String text,
    Color WarnaText,
  ) {
    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 30, color: Warna),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 10, color: WarnaText),
            )
          ],
        ));
  }
}
