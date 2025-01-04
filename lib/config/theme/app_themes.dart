import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blue,
      primaryColorLight: Colors.lightBlue.shade50,
      primaryColorDark: Colors.blue.shade900,
      fontFamily: "Muli",
      appBarTheme: appBarTheme,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
        ),
      ),
    );

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.blue,
      primaryColorLight: Colors.lightBlue.shade50,
      primaryColorDark: Colors.blue.shade900,
      fontFamily: "Muli",
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
        ),
      ),
);

AppBarTheme get appBarTheme => const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      centerTitle: true,
      titleSpacing: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Color(0xFF8B8B8B)),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    );
