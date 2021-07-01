// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// final darkTheme = ThemeData.dark().copyWith(
//   colorScheme: const ColorScheme.dark().copyWith(
//     primary: Colors.teal,
//   ),
//   textButtonTheme: _textButtonThemeData,
// );

// final lightTheme = ThemeData.light().copyWith(
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.deepPurple,
//   ),
//   colorScheme: const ColorScheme.light().copyWith(
//     primary: Colors.orange,
//   ),
//   textButtonTheme: _textButtonThemeData,
// );

final mainLightThemeData = ThemeData.light().copyWith(
  brightness: Brightness.light,
  dividerColor: createMaterialColor(const Color(0xff4454238)),
  hintColor: Colors.black87,
  primaryColor: createMaterialColor(const Color(0xffffffff)),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: createMaterialColor(const Color(0xff4d4d4d)),
  ),
  // primarySwatch: createMaterialColor(const Color(0xff4d4d4d)),
  highlightColor: const Color(0xff6e6e6e),
  backgroundColor: createMaterialColor(const Color(0xeecacaca)),
  accentColor: const Color(0xffe0deda),
  canvasColor: const Color(0xfff0f0f0),
);

final mainDarkThemeData = ThemeData.dark().copyWith(
  buttonColor: createMaterialColor(const Color(0xff505663)),
  dividerColor: createMaterialColor(const Color(0xffcfc099)),
  brightness: Brightness.dark,
  hintColor: Colors.white70,
  accentColor: createMaterialColor(const Color(0xff383736)),
  primaryColor: createMaterialColor(const Color(0xff4d4d4d)),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: createMaterialColor(const Color(0xffefefef)),
  ),
  // primarySwatch: createMaterialColor(const Color(0xffefefef)),
  highlightColor: const Color(0xff6e6e6e),
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  // ignore: avoid_function_literals_in_foreach_calls
  strengths.forEach((strength) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch as Map<int, Color>);
}

MaterialStateProperty<Color> getRandomMaterialStateColor() =>
    MaterialStateProperty.all(
      Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(.25),
    );

Color getRandomMaterialColor() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(.25);

// final _textButtonThemeData = TextButtonThemeData(
//   style: ButtonStyle(
//     textStyle: MaterialStateProperty.all(
//       TextStyle(
//         fontWeight: FontWeight.bold,
//         foreground: Paint()..color = Colors.white,
//         letterSpacing: 2,
//       ),
//     ),
//     padding: MaterialStateProperty.all(
//       const EdgeInsets.symmetric(
//         horizontal: 32,
//       ),
//     ),
//   ),
// );

final buttonStyle = ButtonStyle(
  backgroundColor: getRandomMaterialStateColor(),
  minimumSize: MaterialStateProperty.all(
    const Size(200, 50),
  ),
);

MarkdownStyleSheet getMarkdownStyleSheet(BuildContext context) {
  return MarkdownStyleSheet.fromCupertinoTheme(
    CupertinoThemeData(
      brightness: Theme.of(context).brightness,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontSize: Theme.of(context).textTheme.bodyText1?.fontSize ?? 20,
        ),
      ),
    ),
  );
}

//todo integrate these into the theme itself
ButtonStyle getButtonStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return ButtonStyle(
    elevation: MaterialStateProperty.all(4.0),
    backgroundColor: MaterialStateProperty.all(
      getRandomMaterialColor().withOpacity(.25),
    ),
    padding: MaterialStateProperty.all(const EdgeInsets.all(20.0)),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return isDark ? Colors.red : Colors.red;
      }
      return isDark ? Colors.white : Colors.black;
    }),
    // shape: MaterialStateProperty.all(
    //   RoundedRectangleBorder(
    //     side: BorderSide(
    //       width: 1.0,
    //       color: isDark ? Colors.teal : Colors.lime,
    //     ),
    //   ),
    // ),
  );
}
