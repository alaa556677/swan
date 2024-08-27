import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_constatnts/global.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
    this.closeAppBar = false,
    this.appbar,
    required this.body,
    this.backgroundColor = Global.white,
  });

  final bool closeAppBar;
  final  PreferredSizeWidget? appbar;
  final Widget body;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: closeAppBar ? PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Global.mediumBlue,
            ),
          )
      ) : appbar,
      body: body,
    );
  }
}
