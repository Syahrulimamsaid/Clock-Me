import 'package:clock_me/ModelApp/ScrolTime.dart';
import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:clock_me/Timer/TimerRun.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  FixedExtentScrollController controllerHours = FixedExtentScrollController();
  FixedExtentScrollController controllerMinutes = FixedExtentScrollController();

  String HoursSelect = '00';

  String MinSelect = '00';

  String SecSelect = '00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
          child: Column(
        children: [
          TitlePageModel(Title: "Timer"),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Hour',
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              Text(
                                'Minutes',
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              Text(
                                'Second',
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: ScrollTime(
                                    controller: controllerHours,
                                    onSelect: (value) {
                                      value < 10
                                          ? HoursSelect = '0' + value.toString()
                                          : HoursSelect = value.toString();
                                    },
                                    childCount: 100,
                                  )),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  ":",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 60),
                                ),
                              ),
                              Flexible(
                                  flex: 2,
                                  child: ScrollTime(
                                    controller: controllerHours,
                                    onSelect: (value) {
                                      value < 10
                                          ? MinSelect = '0' + value.toString()
                                          : MinSelect = value.toString();
                                    },
                                    childCount: 60,
                                  )),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  ":",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 50),
                                ),
                              ),
                              Flexible(
                                  flex: 2,
                                  child: ScrollTime(
                                    controller: controllerHours,
                                    onSelect: (value) {
                                      value < 10
                                          ? SecSelect = '0' + value.toString()
                                          : SecSelect = value.toString();
                                    },
                                    childCount: 60,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimerRunPage(
                                      Hour: HoursSelect,
                                      Minutes: MinSelect,
                                      Second: SecSelect,
                                    )),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color.fromARGB(255, 0, 86, 245)),
                          child: Center(
                            child: Text(
                              'Start',
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
