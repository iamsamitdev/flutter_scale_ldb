// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'IBMPlexSansThai',
    primaryColor: primary,
    errorColor: accent,
    hoverColor: divider,
    colorScheme: ColorScheme.light(primary: primary),
    iconTheme: IconThemeData(color: primary_text),
    scaffoldBackgroundColor: icons,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    )
  );
}