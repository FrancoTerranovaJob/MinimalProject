import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MinimalAppTheme {
  static getTheme(BuildContext context) {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              headline2: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              bodyText1: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              bodyText2: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              subtitle1: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
              subtitle2: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFFFFFFFF),
              secondary: const Color(0xFF0D1111),
              surface: const Color(0xFF434545),
            ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Color(0xFF434545),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0D1111))),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC4C4C4))),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFB3A3A))),
          hintStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: const Color(0xFF0D1111)),
        ),
        appBarTheme: const AppBarTheme());
  }
}