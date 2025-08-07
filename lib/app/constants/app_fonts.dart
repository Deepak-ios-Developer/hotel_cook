import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final String primaryFont = GoogleFonts.poppins().fontFamily!;

  // Font sizes
  static const double headline = 24;
  static const double body = 16;
  static const double caption = 12;

  // TextStyles
  static final TextStyle bold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
  );

  static final TextStyle semiBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle regular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
  );

  static final TextStyle medium = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
  );
}
