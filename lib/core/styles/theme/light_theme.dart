import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/global.dart';

ThemeData light = ThemeData(
  primaryColor: Global.mediumBlueLight,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 15.sp
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 28.sp
    )
  )
);
