import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_constatnts/global.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
    this.closeAppBar = false,
    this.appbar,
    required this.body,
  });

  final bool closeAppBar;
  final  PreferredSizeWidget? appbar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: closeAppBar ? PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Theme.of(context).appBarTheme.systemOverlayStyle?.statusBarIconBrightness,
              statusBarColor: Theme.of(context).appBarTheme.systemOverlayStyle?.statusBarColor,
            ),
          )
      ) : appbar,
      body: body,
    );
  }
}
