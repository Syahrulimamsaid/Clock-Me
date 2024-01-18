import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollTime extends StatefulWidget {
  FixedExtentScrollController controller = FixedExtentScrollController();
  Function(int)? onSelect;
  int childCount;
  ScrollTime(
      {super.key,
      required this.controller,
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
        physics: const FixedExtentScrollPhysics(),
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
      margin: const EdgeInsets.all(5),
      child: Text(
        (min < 10) ? "0$min" : min.toString(),
        style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 247, 230, 2),
            fontWeight: FontWeight.w700,
            fontSize: 45),
        textAlign: TextAlign.justify,
      ));
}
