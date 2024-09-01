import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/global.dart';

ThemeData dark = ThemeData(
  primaryColor: Global.buttonColor,
  scaffoldBackgroundColor: Global.bodyColorDark,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Global.buttonColor,
      )
  ),
  cardColor: Global.cardDataColorDark,
  indicatorColor: Global.whiteColor,
  disabledColor: Global.whiteColor,
  iconTheme: const IconThemeData(
    color: Global.whiteColor,
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
        color: Global.whiteColor,
        fontSize: 15.sp
    ),
    titleLarge: TextStyle(
        color: Global.whiteColor,
        fontSize: 28.sp
    )
  )
);
