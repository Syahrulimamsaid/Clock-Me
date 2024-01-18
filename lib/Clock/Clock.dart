import 'dart:async';
import 'dart:math';

import 'package:Clock_Me/Clock/AnalogClock.dart';
import 'package:Clock_Me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late Timer _timer;

  String Jam = '';

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    ViewJam();
    super.initState();
  }

  void ViewJam() {
    setState(() {
      Jam = DateFormat('HH : mm : ss').format(DateTime.now());
    });

    Future.delayed(Duration(seconds: 1), () => {ViewJam()});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
          child: Column(
        children: [
         const  TitlePageModel(Title: "Clock"),
          SizedBox(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    // width: 300,
                    // height: 300,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: CustomPaint(
                        painter: AnalogClock(),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 55),
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        // '${datetime.hour} : ${datetime.minute} : ${datetime.second}'
                        Jam,
                        style: GoogleFonts.notoSans(
                            color: const Color.fromARGB(255, 243, 243, 243),
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
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
