import 'package:clock_me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/Database.dart';
import 'package:clock_me/Alarm/Model/Days.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:clock_me/ModelApp/ScrolTime.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatefulWidget {
  bool StatusAdd;
  int? Id;
  String? Title;
  String? Days;
  int? Hours;
  int? Minutes;

  AddAlarmPage(
      {required this.StatusAdd,
      this.Title,
      this.Days,
      this.Hours,
      this.Id,
      this.Minutes});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  FixedExtentScrollController controllerHours = FixedExtentScrollController();
  FixedExtentScrollController controllerMinutes = FixedExtentScrollController();
  TextEditingController TitleController = TextEditingController();

  String HoursSelect = '00';
  String MinutesSelect = '00';

  String Days = '';
  String DaysInsert = '';
  bool Sun = false;
  bool Mon = false;
  bool Tue = false;
  bool Wed = false;
  bool Thu = false;
  bool Fri = false;
  bool Sat = false;

  String Titik2 = " : ";

  FocusNode Focus = FocusNode();
  bool StatusFocus = false;
  bool StatusDaysSelect = true;
  // bool StatusDatePicker = false;

  final AlarmDatabase = AlarmDb();
  final AlarmQueryExecute = AlarmQuery();

  DateTime selectedDate = DateTime.now();

  void InsertData() async {
    if (TitleController.text.isEmpty) {
      FocusScope.of(context).requestFocus(Focus);
    } else {
      try {
        final InsertData = await AlarmQueryExecute.Insert(
            TitleController.text, HoursSelect, MinutesSelect, DaysInsert, 'On');

        Navigator.pop(context);
      } catch (e) {
        print("gagal insert");
      }
    }
  }

  void UpdateData() async {
    if (TitleController.text.isEmpty) {
      FocusScope.of(context).requestFocus(Focus);
    } else {
      try {
        final UpdateData = await AlarmQueryExecute.Update(widget.Id!,
            TitleController.text, HoursSelect, MinutesSelect, DaysInsert, 'On');

        Navigator.pop(context);
      } catch (e) {
        print("gagal update");
      }
    }
  }

  void CekJam() {
    setState(() {
      if (StatusDaysSelect) {
        DateTime now = DateTime.now();

        var Jam = "${HoursSelect}:${MinutesSelect}";

        Duration MergeJam = DateFormat("HH:mm").parse(Jam).difference(now);

        var JamSekarang = DateFormat("HH:mm").format(now);
        Duration JamHasil =
            DateFormat("HH:mm").parse(JamSekarang).difference(now);

        if (MergeJam >= JamHasil) {
          Days = 'Now-' + FormatDate(DateTime.now());
          DaysInsert =
              DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
          print('Jam lebih');
        } else {
          Days =
              'Tomorrow-' + FormatDate(DateTime.now().add(Duration(days: 1)));
          DaysInsert = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().add(Duration(days: 1)))
              .toString();
          print('Jam Kurang');
        }
      } else {
        print('CekJamTidakJalan');
      }
    });
  }

  void ViewSelectDays() {
    setState(() {
      List<String> selectedDays = [];
      List<String> selectedDaysInsert = [];

      if (Sun) {
        selectedDays.add("Sun");
        selectedDaysInsert.add("1");
      }

      if (Mon) {
        selectedDays.add("Mon");
        selectedDaysInsert.add("2");
      }

      if (Tue) {
        selectedDays.add("Tue");
        selectedDaysInsert.add("3");
      }

      if (Wed) {
        selectedDays.add("Wed");
        selectedDaysInsert.add("4");
      }

      if (Thu) {
        selectedDays.add("Thu");
        selectedDaysInsert.add("5");
      }

      if (Fri) {
        selectedDays.add("Fri");
        selectedDaysInsert.add("6");
      }

      if (Sat) {
        selectedDays.add("Sat");
        selectedDaysInsert.add("7");
      }

      if (selectedDays.isEmpty) {
        StatusDaysSelect = true;
        CekJam();
      } else {
        if (selectedDays.length == 7) {
          Days = 'Every Day';
          DaysInsert = 'Every Day';
        } else {
          Days = "Every ${selectedDays.join(', ')}";
          DaysInsert = "${selectedDaysInsert.join(' ')}";
        }
        StatusDaysSelect = false;
      }
    });
  }

  void CekStatusAdd() {
    if (widget.StatusAdd) {
      CekJam();
    } else {
      Days = widget.Days!;
      DaysInsert = widget.Days!;
      TitleController.text = widget.Title!;
      controllerHours = FixedExtentScrollController(initialItem: widget.Hours!);
      controllerMinutes =
          FixedExtentScrollController(initialItem: widget.Minutes!);

      HoursSelect =
          (widget.Hours! < 10) ? "0${widget.Hours}" : widget.Hours.toString();
      MinutesSelect = (widget.Minutes! < 10)
          ? "0${widget.Minutes}"
          : widget.Minutes!.toString();

      if (isDateFormat(widget.Days!, 'yyyy-MM-dd')) {
        Days = 'Tomorrow-' + FormatDate(DateTime.parse(widget.Days!));
      } else if (widget.Days == 'Every Day') {
        Days = widget.Days!;
        Sun = true;
        Mon = true;
        Tue = true;
        Wed = true;
        Thu = true;
        Fri = true;
        Sat = true;
      } else {
        List<String> hariView = widget.Days!.split(' ');
        List<String> view = [];
        for (String namaHari in hariView) {
          if (namaHari == "1") {
            view.add('Sun');
            Sun = true;
          } else if (namaHari == "2") {
            view.add('Mon');
            Mon = true;
          } else if (namaHari == "3") {
            view.add('Tue');
            Tue = true;
          } else if (namaHari == "4") {
            view.add('Wed');
            Wed = true;
          } else if (namaHari == "5") {
            view.add('Thu');
            Thu = true;
          } else if (namaHari == "6") {
            view.add('Fri');
            Fri = true;
          } else {
            view.add('Sat');
            Sat = true;
          }
          StatusDaysSelect = false;
          print("$namaHari = nama hari");
        }
        Days = "Every ${view.join(', ')}";
      }
    }
  }

  bool isDateFormat(String input, String format) {
    try {
      DateTime? parsedDateTime = DateTime.tryParse(input);

      if (parsedDateTime != null) {
        print('Format tanggal sesuai: $input sesuai dengan pola $format');
        return true;
      } else {
        print(
            'Format tanggal tidak sesuai: $input tidak sesuai dengan pola $format');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    CekStatusAdd();
    TitleController.addListener(AutoFocusTitle);
  }

  void AutoFocusTitle() {
    setState(() {
      StatusFocus = TitleController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    TitleController.dispose();
    Focus.dispose();
    super.dispose();
  }

  Future<void> SelectDate(BuildContext context) async {
    int Year = int.parse(DateFormat('yyyy').format(DateTime.now()));
    int Mount = int.parse(DateFormat('MM').format(DateTime.now()));
    int Day = int.parse(DateFormat('dd').format(DateTime.now()));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(Year, Mount, Day),
      lastDate: DateTime(2101),
    );
    setState(() {
      if (picked != null && picked != selectedDate) {
        StatusDaysSelect = false;
        Sun = false;
        Mon = false;
        Tue = false;
        Wed = false;
        Thu = false;
        Fri = false;
        Sat = false;
        selectedDate = picked;
        Days = FormatDate(selectedDate).toString();
        DaysInsert = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
      } else {
        StatusDaysSelect = true;
        CekJam();
      }
    });
  }

  String FormatDate(DateTime date) {
    return DateFormat('EEEE, MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 8, 44),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
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

                            CekJam();
                          },
                          childCount: 24,
                        )),
                    Flexible(
                      flex: 1,
                      child: Text(
                        ":",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 243, 243, 243),
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
                                ? MinutesSelect = '0' + value.toString()
                                : MinutesSelect = value.toString();

                            CekJam();
                          },
                          childCount: 60,
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 23, 33, 78),
                ),
                margin: EdgeInsets.fromLTRB(15, 35, 15, 15),
                height: MediaQuery.of(context).size.height * 0.53,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Days,
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                fontWeight: FontWeight.w500,
                              )),
                          InkWell(
                            onTap: () => SelectDate(context),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: const Color.fromARGB(255, 243, 243, 243),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DaysView(
                            Colors: (Sun == false)
                                ? const Color.fromARGB(255, 202, 65, 65)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'S',
                            ColorBorder: (Sun == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Sun = !Sun;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Mon == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'M',
                            ColorBorder: (Mon == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Mon = !Mon;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Tue == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'T',
                            ColorBorder: (Tue == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Tue = !Tue;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Wed == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'W',
                            ColorBorder: (Wed == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Wed = !Wed;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Thu == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'T',
                            ColorBorder: (Thu == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Thu = !Thu;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Fri == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'F',
                            ColorBorder: (Fri == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Fri = !Fri;
                                ViewSelectDays();
                              });
                            },
                          ),
                          DaysView(
                            Colors: (Sat == false)
                                ? const Color.fromARGB(255, 243, 243, 243)
                                : Color.fromARGB(255, 145, 49, 224),
                            Teks: 'S',
                            ColorBorder: (Sat == false)
                                ? Colors.transparent
                                : Color.fromARGB(255, 145, 49, 224),
                            ontap: () {
                              setState(() {
                                Sat = !Sat;
                                ViewSelectDays();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextField(
                        maxLength: 20,
                        focusNode: Focus,
                        controller: TitleController,
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 243, 243, 243),
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                        decoration: InputDecoration(
                            hintText: "Alarm Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            counterStyle: TextStyle(
                              color: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 241, 38),
                            ))),
                      ),
                    ),
                    // Text(
                    //   '$HoursSelect : $MinutesSelect $DaysInsert',
                    //   style: TextStyle(fontSize: 30, color: Colors.white),
                    // )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                // color: Color.fromARGB(255, 5, 243, 44),
                height: MediaQuery.of(context).size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text("Cancel",
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 255, 241, 38),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          (widget.StatusAdd) ? InsertData() : UpdateData();
                        },
                        child: Center(
                          child: Text("Save",
                              style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 255, 241, 38),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
