// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

enum ThemeOptions {
  light,
  dim,
  dark,
}

class AppTheme {
  static final themeOptions = {
    ThemeOptions.light: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF3062C8),
      cardColor: const Color(0xFFBABABA),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        headlineSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF000000),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(accentColor: Colors.black)
          .copyWith(secondary: const Color(0xFF000000), error: Colors.red)
          .copyWith(background: const Color(0xFFFFFFFF)),
    ),
    ThemeOptions.dim: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      hintColor: const Color(0xFF8899A6),
      scaffoldBackgroundColor: const Color(0xFF15202B),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(background: const Color(0xFF10171E)),
    ),
    ThemeOptions.dark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      hintColor: const Color(0xFF7A8087),
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(background: const Color(0xFF202327)),
    ),
  };
}
