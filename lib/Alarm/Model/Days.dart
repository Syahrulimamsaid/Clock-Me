import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaysView extends StatefulWidget {
  final String Teks;
  final Color Colors;
  final Color ColorBorder;
  final VoidCallback ontap;
  DaysView({required this.Colors, required this.Teks,required this.ColorBorder, required this.ontap});


  @override
  State<DaysView> createState() => _DaysViewState();
}

class _DaysViewState extends State<DaysView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // color: Colors.red,
            border:
                Border.all(width: 2, color: widget.ColorBorder)),
        child: Center(
          child: Text(widget.Teks,
              style: GoogleFonts.poppins(
                color: widget.Colors,
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
    );
  }
}
