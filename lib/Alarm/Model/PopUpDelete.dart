import 'package:Clock_Me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:Clock_Me/Alarm/Query/AlarmQuery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopUpDelete extends StatefulWidget {
  final String Title;
  final int Id;
  const PopUpDelete({required this.Title, required this.Id});

  @override
  State<PopUpDelete> createState() => _PopUpDeleteState();
}

class _PopUpDeleteState extends State<PopUpDelete> {
  final AlarmDatabase = AlarmDb();
  final AlarmQueryExecute = AlarmQuery();

  void DeleteData() async {
    try {
      final DeleteData = await AlarmQueryExecute.Delete(widget.Id);

      Navigator.pop(context);
    } catch (e) {
      print("gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 23, 33, 78),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      'Yakin akan hapus ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: const Color.fromARGB(255, 243, 243, 243),
                      ),
                    ),
                    Text(
                      widget.Title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 255, 241, 38),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 255, 241, 38),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        DeleteData();
                      },
                      child: Text(
                        'Delete',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 255, 241, 38),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
