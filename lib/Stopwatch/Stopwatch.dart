import 'dart:async';

import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  

  Stopwatch stopwatch = Stopwatch();
  Stopwatch LapTimes = Stopwatch();
  ItemScrollController controller = ItemScrollController();
  late Timer _timer;
  String Start = "Start";
  String Reset = "Lap";
  int Angka = 1;
  List<String> OverallList = [];
  String Minutes = "00";
  String Second = "00";
  String Milisecond = "00";
  String MinutesLapTms = "00";
  String SecondLapTms = "00";
  String MilisecondLapTms = "00";
  bool Status = false;

  @override
  void initState() {
    startTimer();

    controller = ItemScrollController();
    super.initState();
  }

  void startTimer() {
    const oneTenthSecond = Duration(milliseconds: 100);
    _timer = Timer.periodic(oneTenthSecond, (timer) {
      if (stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  void AddOverall(String Nomor) {
    Map<String, String> Items = {
      'Nomor': Nomor,
      'MinutesOverall': Minutes,
      'SecondOverall': Second,
      'MilisecondOverall': Milisecond,
      'MinutesLapTms': MinutesLapTms,
      'SecondLapTms': SecondLapTms,
      'MilisecondLapTms': MilisecondLapTms
    };
    OverallList.add(Items.toString());
    Angka = Angka + 1;

    ControlView();
  }

  Future<void> ControlView() async {
    if (controller != null && OverallList.isNotEmpty) {
      await controller.scrollTo(
        index: OverallList.length - 1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void SetStopwatch() {
    setState(() {
      Minutes = (stopwatch.elapsed.inMinutes < 10)
          ? "0" + stopwatch.elapsed.inMinutes.toString()
          : stopwatch.elapsed.inMinutes.toString();
      Second = (stopwatch.elapsed.inSeconds % 60 < 10)
          ? "0" + (stopwatch.elapsed.inSeconds % 60).toString()
          : (stopwatch.elapsed.inSeconds % 60).toString();
      Milisecond = (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15 < 10)
          ? "0" + (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15).toString()
          : (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15).toString();
    });
  }

  void SetLapTimes() {
    setState(() {
      LapTimes.stop();
      MinutesLapTms = (LapTimes.elapsed.inMinutes < 10)
          ? "0" + LapTimes.elapsed.inMinutes.toString()
          : LapTimes.elapsed.inMinutes.toString();
      SecondLapTms = (LapTimes.elapsed.inSeconds % 60 < 10)
          ? "0" + (LapTimes.elapsed.inSeconds % 60).toString()
          : (LapTimes.elapsed.inSeconds % 60).toString();
      MilisecondLapTms = (LapTimes.elapsed.inMilliseconds % 1000 ~/ 15 < 10)
          ? "0" + (LapTimes.elapsed.inMilliseconds % 1000 ~/ 15).toString()
          : (LapTimes.elapsed.inMilliseconds % 1000 ~/ 15).toString();

      LapTimes.reset();
      LapTimes.start();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String Minutess = "00";
  String Seconds = "00";
  String Miliseconds = "00";
  @override
  Widget build(BuildContext context) {
    Minutess = (stopwatch.elapsed.inMinutes < 10)
        ? "0" + stopwatch.elapsed.inMinutes.toString()
        : stopwatch.elapsed.inMinutes.toString();
    Seconds = (stopwatch.elapsed.inSeconds % 60 < 10)
        ? "0" + (stopwatch.elapsed.inSeconds % 60).toString()
        : (stopwatch.elapsed.inSeconds % 60).toString();
    Miliseconds = (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15 < 10)
        ? "0" + (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15).toString()
        : (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15).toString();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
        child: Column(
          children: [
            TitlePageModel(Title: "Stopwatch"),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 25, 5, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeBox(
                        // (stopwatch.elapsed.inMinutes < 10)
                        //     ? "0" + stopwatch.elapsed.inMinutes.toString()
                        //     : stopwatch.elapsed.inMinutes.toString(),
                        Minutess,
                        "Minutes"),
                    Text(
                      ":",
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 243, 243, 243),
                          fontWeight: FontWeight.w400,
                          fontSize: 40),
                    ),
                    TimeBox(
                        // (stopwatch.elapsed.inSeconds % 60 < 10)
                        //     ? "0" +
                        //         (stopwatch.elapsed.inSeconds % 60).toString()
                        //     : (stopwatch.elapsed.inSeconds % 60).toString(),
                        Seconds,
                        "Second"),
                    Text(
                      ".",
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 243, 243, 243),
                          fontWeight: FontWeight.w400,
                          fontSize: 40),
                    ),
                    TimeBox(
                        // (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15 < 10)
                        //     ? "0" +
                        //         (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15)
                        //             .toString()
                        //     : (stopwatch.elapsed.inMilliseconds % 1000 ~/ 15)
                        //         .toString(),
                        Miliseconds,
                        "MiliSecond")
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: (Status == false)
                  ? SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // color: Colors.purple,
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: Center(
                                  child: Text(
                                    "Lap",
                                    style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 243, 243, 243),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                // color: Colors.green,
                                width: MediaQuery.of(context).size.width * 0.23,
                                child: Text(
                                  "Lap times",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                // color: Colors.green,
                                width: MediaQuery.of(context).size.width * 0.23,
                                child: Text(
                                  "Overall times",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.002,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 233, 233),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Container(
                          // color: Colors.yellow,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.30,
                          padding: EdgeInsets.all(5),
                          child: ScrollablePositionedList.builder(
                              itemScrollController: controller,
                              itemCount: OverallList.length,
                              itemBuilder: (context, index) {
                                Map<String, String> lapItem = Map.fromEntries(
                                  OverallList[index]
                                      .replaceAll(RegExp('[{}]'), '')
                                      .split(', ')
                                      .map((entry) {
                                    final parts = entry.split(': ');
                                    return MapEntry(parts[0], parts[1]);
                                  }),
                                );
                                return Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        child: Center(
                                          child: Text(
                                            lapItem['Nomor']!,
                                            style: GoogleFonts.poppins(
                                                color: const Color.fromARGB(
                                                    255, 243, 243, 243),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        child: Text(
                                          lapItem['MinutesLapTms']! +
                                              " : " +
                                              lapItem['SecondLapTms']! +
                                              " . " +
                                              lapItem['MilisecondLapTms']!,
                                          style: GoogleFonts.poppins(
                                              color: const Color.fromARGB(
                                                  255, 243, 243, 243),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.5),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        child: Text(
                                          lapItem['MinutesOverall']! +
                                              " : " +
                                              lapItem['SecondOverall']! +
                                              " . " +
                                              lapItem['MilisecondOverall']!,
                                          style: GoogleFonts.poppins(
                                              color: const Color.fromARGB(
                                                  255, 243, 243, 243),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.5),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      setState(() {
                        if (Start == "Start") {
                          Start = "Stop";
                          Reset = "Lap";
                          stopwatch.start();
                          LapTimes.start();
                          startTimer();
                         
                        } else if (Start == "Stop") {
                          Start = "Resume";
                          Reset = "Reset";
                          stopwatch.stop();
                          LapTimes.stop();
                        } else if (Start == "Resume") {
                          Start = "Stop";
                          Reset = "Lap";
                          stopwatch.start();
                          LapTimes.start;
                          startTimer();
                        } else {}
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: (stopwatch.isRunning)
                              ? Color.fromARGB(255, 177, 23, 11)
                              : Color.fromARGB(255, 0, 86, 245)),
                      child: Center(
                        child: Text(
                          Start,
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 243, 243, 243),
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
                        if (Reset == "Reset") {
                          Reset = "Lap";
                          Start = "Start";
                          OverallList.clear();
                          Angka = 1;
                          stopwatch.reset();
                          LapTimes.reset();
                          Status = false;
                        } else if (Start == "Stop") {
                          setState(() {
                            SetStopwatch();
                            SetLapTimes();
                            AddOverall(Angka.toString());
                            Status = true;
                          });
                        } else if (Start == "Start") {}
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: (Start == "Start")
                              ? Color.fromARGB(255, 87, 87, 87)
                              : Color.fromARGB(255, 110, 110, 110)),
                      child: Center(
                        child: Text(
                          Reset,
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column TimeBox(String Time, String Title) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 33, 78),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              Time,
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 247, 230, 2),
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            Title,
            style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 243, 243, 243),
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        )
      ],
    );
  }
}
