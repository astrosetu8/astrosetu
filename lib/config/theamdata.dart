import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: const Color(0xFF2196F3), // Neon Blue for primary theme
  scaffoldBackgroundColor: const Color(0xFF121212), // Dark Gray background
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xffBC30AA).withOpacity(0.7), // Bright Blue
      foregroundColor: Colors.white, // White text on buttons
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for buttons
      ),
    ),
  ),
  appBarTheme:   AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Colors.deepPurple.withOpacity(0.8),
    surfaceTintColor: Color(0xFF2196F3), // Bright Blue tint
    titleTextStyle: TextStyle(
      color: Colors.white, // White text for AppBar title
      fontSize: 20, // Larger font size for title
      fontWeight: FontWeight.bold, // Bold AppBar title
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary, // Consistent button text styling
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 22, // Larger font for titles
      color: Colors.white, // White text for readability
      fontWeight: FontWeight.bold, // Bold titles
    ),
    bodySmall: TextStyle(
      fontSize: 14, // Smaller font for secondary text
      color: Color(0xFFBDBDBD), // Light Gray for secondary text
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2196F3)), // Neon Blue border
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFFEB3B)), // Neon Yellow on focus
    ),
    contentPadding: EdgeInsets.all(12), // Padding for input fields
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded borders
    ),
    hintStyle: TextStyle(color: Color(0xFF757575)), // Darker Gray hints
    fillColor: Color(0xFF1E1E1E), // Slightly lighter gray background for inputs
    filled: true, // Enables background color for inputs
  ),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: const Color(0xFF2196F3), // Bright Blue for primary theme
  scaffoldBackgroundColor: const Color(0xffFFF9ED), // Light Beige for background
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight:
        FontWeight.bold, // Set the font weight to medium
        fontSize: 16.0, // Set a reasonable font size
      ),
      backgroundColor:
      Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 30.0),
      foregroundColor: Colors.white, // White text on buttons
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
  ),
  appBarTheme:   AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: const Color(0xffFFF9ED),
    // surfaceTintColor: Color(0xFF2196F3), // Bright Blue tint
    titleTextStyle: TextStyle(
      color: Colors.black, // White text for AppBar title
      fontSize: 20, // Larger font size for title
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary, // Consistent button text styling
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(

      fontSize: 22, // Larger font for titles
      color: Colors.white, // Dark Gray for readability
      fontWeight: FontWeight.bold, // Bold titles
    ),
    bodySmall: TextStyle(
      fontSize: 14, // Smaller font for less emphasis
      color: Color(0xFF757575), // Light Gray for secondary text
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: Color(0xFF2196F3)), // Bright Blue border
    // ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffBC30AA)), // Sunny Yellow on focus
    ),
    contentPadding: EdgeInsets.all(12), // Padding for input fields
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded borders
    ),
    hintStyle: TextStyle(color: Color(0xFF757575)), // Light Gray hints
    fillColor: Color(0xFFFAFAFA), // Light Beige background for inputs
    filled: true, // Enables background color for inputs
  ),
);




