import 'package:cart_app/images.dart';
import 'package:cart_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80.0,
              bottom: 40.0,
              top: 160.0,
            ),
            child: Image.asset(ImagesAssets.cart),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "We Deliver groceries at your doorstep",
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSerif(
                fontSize: 36.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            "Fresh items everyday",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
