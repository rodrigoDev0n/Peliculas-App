import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light()
  );

  static final lightTextColor = TextStyle(
    color: Colors.white,
  );

  static final darkTextColor = TextStyle(
    color: Colors.grey.shade900
  );

}