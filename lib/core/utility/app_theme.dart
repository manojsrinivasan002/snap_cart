import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final lightMode = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF580459), brightness: Brightness.light),
    useMaterial3: true,
  );

  // static final darkMode = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: Colors.black,
  //     brightness: Brightness.dark,
  //   ),
  //   useMaterial3: true,
  // );
}
