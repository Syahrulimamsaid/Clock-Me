import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clock_me/Alarm/Alarm.dart';
import 'package:clock_me/Home/Home.dart';
import 'package:clock_me/Stopwatch/Stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Alarm: Waktunya melakukan sesuatu!");

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  String hari = "Senin Selasa Rabu";

  // Memisahkan string menjadi list menggunakan spasi sebagai pemisah
  List<String> daftarHari = hari.split(' ');

  // Menampilkan hasil pemisahan
  for (String namaHari in daftarHari) {
    print("Hari: $namaHari");
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
