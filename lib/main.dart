import 'package:assignment1/weatherplace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts
            .poppinsTextTheme(), // Apply Poppins font to make app more visually appealing
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const WeatherPlace(),
      ),
    ),
  );
}
