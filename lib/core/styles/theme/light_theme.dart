import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/global.dart';

ThemeData light = ThemeData(
  primaryColor: Global.buttonColor,
  scaffoldBackgroundColor: Global.bodyColorLight,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Global.buttonColor,
    )
  ),
  iconTheme: const IconThemeData(
    color: Global.whiteColor,
  ),
  cardColor: Global.cardDataColorLight,
  indicatorColor: Global.blackColor.withOpacity(.90),
  disabledColor: Global.unSelectedColor,
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: Global.blackColor,
      fontSize: 15.sp
    ),
    titleLarge: TextStyle(
      color: Global.blackColor,
      fontSize: 28.sp
    )
  )
);
