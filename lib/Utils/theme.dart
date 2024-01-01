import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light =
      ThemeData(primaryColor: bluishClr, brightness: Brightness.light,appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0),);
  static final dark =
      ThemeData(primaryColor: darkGreyClr, brightness: Brightness.dark,appBarTheme: AppBarTheme(backgroundColor: darkGreyClr,elevation: 0));
}
