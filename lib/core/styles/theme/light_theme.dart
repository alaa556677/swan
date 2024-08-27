import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF032D3D),
  secondaryHeaderColor: const Color(0xff152129),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: const Color(0xFFE6E6E6),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xff195D9B),
    ),
  ), colorScheme: const ColorScheme.light(
  primary: Color(0xff195D9B),
  secondary: Color(0xff195D9B),).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xffE50909)),
);
