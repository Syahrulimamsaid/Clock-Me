import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 8, 44),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: const Image(
                image:
                    AssetImage('assets/images/Logo Clock Me Transparent.png'),
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Clock  Me',
              style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: const Color.fromARGB(255, 243, 243, 243),
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              child: Text(
                'Clock Me merupakan aplikasi yang dikembangkan untuk pengguna yang membutuhkan manajemen waktu dengan akurat beserta dukungan fitur yang disediakan.',
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.033,
                    color: const Color.fromARGB(255, 243, 243, 243),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
