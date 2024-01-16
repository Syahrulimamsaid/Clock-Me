import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:clock_me/Notification/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerRunPage extends StatefulWidget {
  String Hour;
  String Minutes;
  String Second;
  TimerRunPage(
      {required this.Hour, required this.Minutes, required this.Second});

  @override
  State<TimerRunPage> createState() => _TimerRunPageState();
}

class _TimerRunPageState extends State<TimerRunPage> {
  var firshDuration = Duration();
  var duration = Duration();
  Timer? timer;
  String Start = 'Resume';
  String Cancel = 'Cancel';

  bool isRunning = true;
  bool run = false;

  double percent = 1.0;

  var Hour = '';
  var Minutes = '';
  var Second = '';

  @override
  void initState() {
    firshDuration = Duration(
        hours: int.parse(widget.Hour),
        minutes: int.parse(widget.Minutes),
        seconds: int.parse(widget.Second));
    cekPause();
    super.initState();
  }

  void StartCountDown(int hour, min, sec) async {
    duration = Duration(hours: hour, minutes: min, seconds: sec);
    // double durationTotal = double.parse(duration.inSeconds.toString());

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final second = duration.inSeconds - 1;

        percent = second / firshDuration.inSeconds;

        if (second < 0) {
          timer.cancel();
          percent = 0.0;
          Navigator.pop(context);
          NotificationService.showNotification(1000,
              Title: 'Timer',
              Body: 'Timer Sudah Selesai',
              statusSchedule: false,
              actionButtons: [
                NotificationActionButton(key: 'Dismiss', label: 'Dismiss')
              ]);
        } else {
          duration = Duration(seconds: second);

          String formatTeks(int n) => n.toString().padLeft(2, '0');
          Hour = formatTeks(duration.inHours.remainder(100));
          Minutes = formatTeks(duration.inMinutes.remainder(60));
          Second = formatTeks(duration.inSeconds.remainder(60));
        }
      });
    });
  }

  void cekPause() {
    if (isRunning) {
      if (run) {
        StartCountDown(int.parse(Hour), int.parse(Minutes), int.parse(Second));
      } else {
        StartCountDown(int.parse(widget.Hour), int.parse(widget.Minutes),
            int.parse(widget.Second));
      }
    } else {
      timer!.cancel();
      run = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatTeks(int n) => n.toString().padLeft(2, '0');
    final hour = formatTeks(duration.inHours.remainder(100));
    final minutes = formatTeks(duration.inMinutes.remainder(60));
    final second = formatTeks(duration.inSeconds.remainder(60));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Container(
                child: CircularPercentIndicator(
                  animation: false,
                  radius: 170,
                  lineWidth: 10,
                  percent: percent,
                  progressColor: Color.fromARGB(255, 247, 230, 2),
                  backgroundColor: Color.fromARGB(255, 23, 33, 78),
                  circularStrokeCap: CircularStrokeCap.square,
                  center: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Digit(hour)),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ":",
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                fontWeight: FontWeight.w400,
                                fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(flex: 2, child: Digit(minutes)),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ":",
                            style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                fontWeight: FontWeight.w400,
                                fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(flex: 2, child: Digit(second)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            if (Start == "Resume") {
                              Start = "Stop";
                              isRunning = false;
                              cekPause();
                            } else if (Start == "Stop") {
                              Start = "Resume";
                              isRunning = true;
                              cekPause();
                            } else {}
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: (Start == 'Stop')
                                  ? Color.fromARGB(255, 177, 23, 11)
                                  : Color.fromARGB(255, 0, 86, 245)),
                          child: Center(
                            child: Text(
                              Start,
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            timer!.cancel();
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color.fromARGB(255, 110, 110, 110)),
                          child: Center(
                            child: Text(
                              Cancel,
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }

  Text Digit(String hour) {
    return Text(
      hour,
      style: GoogleFonts.poppins(
          color: Color.fromARGB(255, 247, 230, 2),
          fontWeight: FontWeight.w700,
          fontSize: 40),
      textAlign: TextAlign.center,
    );
  }
}
