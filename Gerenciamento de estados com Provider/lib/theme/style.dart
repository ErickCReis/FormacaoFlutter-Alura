import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ).copyWith(
      secondary: Colors.blueAccent.shade400,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.blueAccent.shade400,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
    ).copyWith(
      secondary: Colors.blueAccent.shade700,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.blueAccent.shade700,
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.green.shade900),
  );
}
