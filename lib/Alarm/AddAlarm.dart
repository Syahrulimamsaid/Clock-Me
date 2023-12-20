import 'package:clock_me/Alarm/DatabaseAlarm/AlarmDb.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/AlarmModel.dart';
import 'package:clock_me/Alarm/DatabaseAlarm/Database.dart';
import 'package:clock_me/Alarm/Model/Days.dart';
import 'package:clock_me/Alarm/Query/AlarmQuery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({
    super.key,
  });

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  FixedExtentScrollController controllerHours = FixedExtentScrollController();
  FixedExtentScrollController controllerMinutes = FixedExtentScrollController();
  FixedExtentScrollController controllerAmPm = FixedExtentScrollController();
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
        print("gagal");
      }
    }
  }

  void ViewSelectDays() {
    List<String> selectedDays = [];

    if (Sun) selectedDays.add("Sun");
    if (Mon) selectedDays.add("Mon");
    if (Tue) selectedDays.add("Tue");
    if (Wed) selectedDays.add("Wed");
    if (Thu) selectedDays.add("Thu");
    if (Fri) selectedDays.add("Fri");
    if (Sat) selectedDays.add("Sat");

    if (selectedDays.isEmpty) {
      Days = 'Tomorrow-' + FormatDate(DateTime.now().add(Duration(days: 1)));
      DaysInsert = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    } else {
      if (selectedDays.length == 7) {
        Days = 'Every Day';
        DaysInsert = 'Every Day';
      } else {
        Days = "Every ${selectedDays.join(', ')}";
        DaysInsert = "Every ${selectedDays.join(', ')}";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Days = 'Tomorrow-' + FormatDate(DateTime.now().add(Duration(days: 1)));
    DaysInsert = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
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

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Days = FormatDate(selectedDate).toString();
        DaysInsert = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
      });
    }
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
                      child: ListWheelScrollView.useDelegate(
                          itemExtent: 70,
                          physics: FixedExtentScrollPhysics(),
                          perspective: 0.0005,
                          controller: controllerHours,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              value < 10
                                  ? HoursSelect = '0' + value.toString()
                                  : HoursSelect = value.toString();
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 24,
                              builder: (context, index) {
                                return TimeDigitHours(index);
                              })),
                    ),
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
                      child: ListWheelScrollView.useDelegate(
                          itemExtent: 70,
                          controller: controllerMinutes,
                          perspective: 0.0005,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              value < 10
                                  ? MinutesSelect = '0' + value.toString()
                                  : MinutesSelect = value.toString();
                            });
                          },
                          physics: FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 60,
                              builder: (context, index) {
                                return TimeDigitMinutes(index);
                              })),
                    ),
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
                    Text(
                      " $DaysInsert  $HoursSelect : $MinutesSelect",
                      style: TextStyle(fontSize: 30),
                    )
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
                          InsertData();
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

  Container TimeDigitMinutes(int min) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Text(
          (min < 10) ? "0" + min.toString() : min.toString(),
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 247, 230, 2),
              fontWeight: FontWeight.w700,
              fontSize: 50),
          textAlign: TextAlign.justify,
        ));
  }

  Container TimeDigitHours(int min) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Text(
          (min < 10) ? "0" + min.toString() : min.toString(),
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 247, 230, 2),
              fontWeight: FontWeight.w700,
              fontSize: 50),
          textAlign: TextAlign.justify,
        ));
  }

  Container AmPm(bool AmPm) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Text(
          (AmPm == true) ? "AM" : "PM",
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 247, 230, 2),
              fontWeight: FontWeight.w700,
              fontSize: 50),
          textAlign: TextAlign.justify,
        ));
  }
}
