import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  // scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xffF2F2F4),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xff4558FF),
    tertiary: const Color(0xff4A4A4A),
  ),
  focusColor: const Color(0xff2FA6A7), // instead of button color
  indicatorColor: const Color(0xffEBEBEB),
  hintColor: const Color(0xff9D9D9D),
  highlightColor: const Color(0xff909BFF),

  // disabledColor: const Color(0xffDFDFDF),
  // shadowColor: const Color(0xff000000),
  // errorColor: const Color(0xffD63649),
  // drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff280035)),
  cardTheme: const CardTheme(
      color: Color(0xffFBFBFB), shadowColor: Color(0xff000000), elevation: 15),
  fontFamily: "Manrope",
  textTheme: const TextTheme(
    displaySmall:
        TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 16),
    headlineLarge: TextStyle(
        color: Color(0xff2FA6A7),
        fontSize: 24,
        fontFamily: "Playfair Display",
        fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(
        color: Color(0xff531255), fontSize: 22, fontFamily: "Playfair Display"),
    // headlineSmall: TextStyle(
    //     color: Color(0xff531255), fontSize: 18, fontFamily: "IBMPlexSans"),
    titleLarge: TextStyle(color: Color(0xff5F5F5F), fontSize: 24),
    titleMedium: TextStyle(color: Color(0xff5F5F5F), fontSize: 20),
    titleSmall: TextStyle(color: Color(0xff5F5F5F), fontSize: 13),
    // bodyLarge: TextStyle(color: Color(0xff4A4A4A), fontSize: 18),
    bodyMedium: TextStyle(
        color: Color(0xff363030), fontSize: 14, fontWeight: FontWeight.w600),
    bodySmall: TextStyle(color: Color(0xff9EA3A2), fontSize: 12),
    // labelLarge: TextStyle(color: Color(0xffB0BAC9), fontSize: 18),
    labelMedium: TextStyle(color: Color(0xffA5A5A5), fontSize: 15),
    labelSmall: TextStyle(color: Color(0xff333333), fontSize: 13),
  ),
);
