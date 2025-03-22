import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static var header1 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const header2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const subtitle1 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static var subtitle2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const subtitle3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static const body1 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const body2 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const buttonText = TextStyle(fontSize: 18, color: Colors.white);
  static const actionButtonText = TextStyle(fontSize: 16, color: Colors.black);
  static const primaryText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFF006FFd),
  );
  static const primaryBoldText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFF006FFd),
  );

  static var normalText = GoogleFonts.poppins(color: Colors.black);
  static const logout = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.red,
  );
}
