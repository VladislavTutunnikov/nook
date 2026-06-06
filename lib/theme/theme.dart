import 'package:flutter/material.dart';
import 'package:nook/theme/colors.dart';

const _textTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),

  headlineMedium: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    height: 1.2,
  ),

  titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.3),

  titleMedium: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.4,
  ),

  bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.4),

  labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.5),
);

final whiteTheme = ThemeData(
  fontFamily: 'Inter',
  textTheme: _textTheme,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 0, 0),
  ),
  scaffoldBackgroundColor: AppColors.background,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.darkGrey,
    showUnselectedLabels: false,
    showSelectedLabels: false,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.white,
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.darkGrey, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.black, width: 1),
    ),
    labelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.darkGrey,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.only(
      top: 15,
      bottom: 5,
      left: 10,
      right: 15,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.black,
    selectionColor: Color.fromARGB(40, 0, 0, 0),
    selectionHandleColor: AppColors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.white,
    shape: CircleBorder(side: BorderSide(color: AppColors.lightGrey, width: 1)),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(1000),
      side: const BorderSide(width: 1, color: AppColors.lightGrey),
    ),
    backgroundColor: AppColors.white,
    elevation: 0,
    contentTextStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 17,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: AppColors.black,
    ),
  ),
);
