import 'dart:async';
import 'dart:math';

import 'package:clock_me/Alarm/Model/AnalogClock.dart';
import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
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
          TitlePageModel(Title: "Clock"),
          Container(
            margin: EdgeInsets.only(top: 50),
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
          )
        ],
      )),
    );
  }
}
