import 'package:flutter/material.dart';

final bytebankTheme = ThemeData(
  primaryColor: Colors.green.shade900,
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: Colors.green.shade900,
        secondary: Colors.blueAccent.shade700,
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.blueAccent.shade700,
    ),
  ),
);
