import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.teal,
  ),
  primaryTextTheme: const TextTheme().copyWith(
    headline1: const TextStyle().copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Colors.white,
    ),
  ),
  textButtonTheme: _textButtonThemeData,
);

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
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
        fontSize: 22,
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
