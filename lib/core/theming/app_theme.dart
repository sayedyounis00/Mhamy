import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF6A3DE8),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6A3DE8),
      secondary: const Color(0xFF00D9C6),
      tertiary: const Color(0xFFFF4081),
    ),
    textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3: true,
  );
}
