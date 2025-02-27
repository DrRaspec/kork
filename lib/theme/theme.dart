import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xffC9131E),
    secondary: Color.fromRGBO(51, 51, 51, 1),
    tertiary: Color(0xff404144),
    surfaceTint: Color(0xA0404144),
    onInverseSurface: Color(0xff1C1818),
  ),
  // scaffoldBackgroundColor: const Color(0xffF7F8F9),?
  appBarTheme: const AppBarTheme(
    color: Color(0xffF7F8F9),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFAFAFA),
  ),
  datePickerTheme: DatePickerThemeData(
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0xff9CA3AF); // passed dates
      }
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return const Color(0xff1C1818); // normal dates
    }),
    todayForegroundColor: WidgetStateProperty.all(
      const Color(0xff1C1818),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xffC9131E),
    secondary: Color(0xff333333),
    tertiary: Color(0xffEAE9FC),
    surfaceTint: Color(0x80EAE9FC),
    onInverseSurface: Color(0xff1C1818),
  ),
  scaffoldBackgroundColor: const Color(0xff252525),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1C1818),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffFAFAFA),
  ),
  datePickerTheme: DatePickerThemeData(
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0xffEAE9FC).withOpacity(0.5); // passed dates
      }
      return const Color(0xffEAE9FC); // normal dates
    }),
    todayForegroundColor: WidgetStateProperty.all(const Color(0xffEAE9FC)),
  ),
);

extension CustomColorScheme on ColorScheme {
  Color get filterBackground => brightness == Brightness.dark
      ? const Color(0x80404144)
      : Colors.transparent;
}
