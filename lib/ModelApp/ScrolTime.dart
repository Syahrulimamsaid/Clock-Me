import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollTime extends StatefulWidget {
  FixedExtentScrollController controller = FixedExtentScrollController();
  Function(int)? onSelect;
  int childCount;
  ScrollTime(
      {required this.controller,
      required this.onSelect,
      required this.childCount});

  @override
  State<ScrollTime> createState() => _ScrollTimeState();
}

class _ScrollTimeState extends State<ScrollTime> {
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
        itemExtent: 70,
        physics: FixedExtentScrollPhysics(),
        perspective: 0.0005,
        controller: widget.controller,
        onSelectedItemChanged: (value) {
          setState(() {
            widget.onSelect?.call(value);
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: widget.childCount,
            builder: (context, index) {
              return TimeDigit(index);
            }));
  }
}

Container TimeDigit(int min) {
  return Container(
      margin: EdgeInsets.all(5),
      child: Text(
        (min < 10) ? "0" + min.toString() : min.toString(),
        style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 247, 230, 2),
            fontWeight: FontWeight.w700,
            fontSize: 45),
        textAlign: TextAlign.justify,
      ));
}
