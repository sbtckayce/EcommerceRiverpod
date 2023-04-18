


import 'package:e_commerce/constants/coloors.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Coloors.whiteColor,
  primaryColor: Coloors.greenColor,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: Coloors.greenColor,
          textStyle:  TextStyle(
            color: Coloors.greenColor,
          ),
          side:  BorderSide(color: Coloors.greenColor, width: 1.7),
          disabledForegroundColor: Coloors.greenColor.withOpacity(0.38))),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Coloors.greenColor,
     
      disabledBackgroundColor: Coloors.greyColor,
    ),
  ),
  canvasColor:  Coloors.greenColor,
  appBarTheme:  AppBarTheme(
    backgroundColor: Coloors.whiteColor,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Coloors.blackColor
    ),
    iconTheme: IconThemeData(color: Coloors.blackColor)
  )
);

OutlineInputBorder outlineInputBorder =  OutlineInputBorder(
  borderSide: BorderSide(
    color: Coloors.greyColor,
  ),
);