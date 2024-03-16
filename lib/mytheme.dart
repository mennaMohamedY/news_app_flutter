

import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor=Color(0xff39A552);

  static ThemeData myTheme=ThemeData(
    appBarTheme: AppBarTheme(color: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))),
    centerTitle: true)

  );
}