import 'package:clock_me/ModelApp/TitlePage.dart';
import 'package:flutter/material.dart';

class DetailAlarm extends StatefulWidget {
  const DetailAlarm({super.key});

  @override
  State<DetailAlarm> createState() => _DetailAlarmState();
}

class _DetailAlarmState extends State<DetailAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: SafeArea(
          child: Column(
        children: [
          TitlePageModel(Title: "Detail Alarm"),
        ],
      )),
    );
  }
}
