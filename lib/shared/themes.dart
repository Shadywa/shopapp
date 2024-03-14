import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode =  ThemeData(

appBarTheme: const AppBarTheme(
elevation: 0,
backwardsCompatibility: false,
systemOverlayStyle:
SystemUiOverlayStyle(statusBarColor: Colors.white),
backgroundColor: Colors.white,
iconTheme: IconThemeData(
color: Colors.black,
size: 24,
),
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 24,
fontWeight: FontWeight.bold),

),
scaffoldBackgroundColor: Colors.white,
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
elevation: 20,
backgroundColor: Colors.white,
selectedItemColor: Colors.deepOrange,
unselectedItemColor: Colors.black,
),

textTheme: const TextTheme(
bodyText1: TextStyle(
color: Colors.black,
fontSize: 16,
fontWeight: FontWeight.bold,
),
bodyText2:TextStyle( fontSize: 12,color: Colors.black),
labelMedium:TextStyle( fontSize: 15,color: Colors.grey),
    subtitle1: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold)


),

);



ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black45,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Colors.black45,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold
      )),
  scaffoldBackgroundColor: Colors.black45,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black45,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyText2:TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.white),
    labelMedium:TextStyle( fontSize: 15,color: Colors.grey),
    subtitle1: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold)
  ),
);