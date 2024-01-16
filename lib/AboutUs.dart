import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 8, 44),
      body: Center(
        child: Text(
          'Clock  Me',
          style: GoogleFonts.poppins(
              fontSize: 45,
              color: const Color.fromARGB(255, 243, 243, 243),
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
