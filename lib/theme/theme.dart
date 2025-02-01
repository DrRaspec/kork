import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xffC9131E),
    secondary: Color(0xff4B5563),
    tertiary: Color(0xff9CA3AF),
    surfaceTint: Color(0xffD1D5DB), // For disabled components
    onInverseSurface: Color(0xffF7F8F9), // For inverted text & icons
  ),
  scaffoldBackgroundColor: const Color(0xff1C1818),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFAFAFA),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xffC9131E),
    secondary: Color(0xff333333),
    tertiary: Color(0xffEAE9FC), //text
    surfaceTint: Color(0x80EAE9FC), // For disabled components
    onInverseSurface: Color(0xff1C1818), // For inverted text & icons
  ),
  scaffoldBackgroundColor: const Color(0xff1C1818),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFAFAFA),
  ),
);
