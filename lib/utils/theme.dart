import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.teal,
  ),
  textButtonTheme: _textButtonThemeData,
);

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepPurple,
  ),
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.orange,
  ),
  textButtonTheme: _textButtonThemeData,
);

final _textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      TextStyle(
        fontWeight: FontWeight.bold,
        foreground: Paint()..color = Colors.white,
        letterSpacing: 2,
      ),
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: 32,
      ),
    ),
  ),
);
