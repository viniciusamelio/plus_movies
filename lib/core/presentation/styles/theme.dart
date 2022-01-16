import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

final theme = ThemeData(
  backgroundColor: Colors.white,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    fillColor: gray08,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: gray02,
    ),
    floatingLabelStyle: TextStyle(
      color: gray02,
    ),
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(
          100,
        ),
      ),
    ),
  ),
  fontFamily: GoogleFonts.montserrat().fontFamily,
  colorScheme: const ColorScheme(
    background: bgLight,
    secondary: darkGreen01,
    secondaryVariant: darkGreen01,
    primary: bgLight,
    primaryVariant: gray02,
    surface: gray08,
    error: Colors.red,
    onPrimary: gray01,
    onSecondary: Colors.white,
    onSurface: gray01,
    onBackground: gray01,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
