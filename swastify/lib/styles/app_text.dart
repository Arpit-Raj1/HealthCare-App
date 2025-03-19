import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static var header1 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const header2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const subtitle1 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static var subtitle2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const subtitle3 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const body1 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const body2 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const buttonText = TextStyle(fontSize: 18, color: Colors.white);
  static var normalText = GoogleFonts.poppins(color: Colors.black);
}
