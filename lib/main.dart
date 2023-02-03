import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: const HomePage());
  }
}

ThemeData myTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        cardColor: Colors.grey),
    textTheme: GoogleFonts.ralewayTextTheme(const TextTheme(
      headlineLarge:
          TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
    )));