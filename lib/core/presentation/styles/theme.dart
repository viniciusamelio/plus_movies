import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

final theme = ThemeData(
  backgroundColor: Colors.white,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  colorScheme: const ColorScheme(
    background: bgLight,
    secondary: darkGreen01,
    secondaryVariant: darkGreen01,
    primary: bgLight,
    primaryVariant: bgLight,
    surface: gray08,
    error: Colors.red,
    onPrimary: gray01,
    onSecondary: Colors.white,
    onSurface: gray01,
    onBackground: gray02,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
