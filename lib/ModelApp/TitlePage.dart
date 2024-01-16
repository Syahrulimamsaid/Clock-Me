import 'package:clock_me/AboutUs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlePageModel extends StatefulWidget {
  final String Title;
  const TitlePageModel({required this.Title});

  @override
  State<TitlePageModel> createState() => _TitlePageModelState();
}

class _TitlePageModelState extends State<TitlePageModel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(widget.Title,
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 243, 243, 243),
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
            ),
          ),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(20),
                child: PopupMenuButton(
                    color: Color.fromARGB(255, 23, 33, 78),
                    icon: Icon(FontAwesomeIcons.ellipsisVertical,
                        color: const Color.fromARGB(255, 243, 243, 243)),
                    onSelected: (value) {
                      if (value == '1') {
                      } else if (value == '2') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsPage()),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: "1",
                          child: Text('Settings',
                              style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(
                                      255, 243, 243, 243))),
                        ),
                        PopupMenuItem<String>(
                          value: '2',
                          child: Text('About Us',
                              style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(
                                      255, 243, 243, 243))),
                        ),
                      ];
                    }),
              )),
        )
      ],
    );
  }
}
