import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.orange,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
    appBarTheme: const AppBarTheme(
        titleSpacing: 20,
        backgroundColor: primary,
        backwardsCompatibility: false,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: primary,
            statusBarBrightness: Brightness.light),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.black45,
        elevation: 30),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black)),

  );
}
