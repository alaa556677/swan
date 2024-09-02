import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/navigate_methods.dart';
import 'package:swan/core/app_constatnts/routes.dart';

import '../app_constatnts/app_localization.dart';
import 'button_widget.dart';
import 'deafault_screen.dart';

class NetworkFailedScreen extends StatelessWidget {
  const NetworkFailedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/networkFailed.jpg"),
          SizedBox(height: 12.h,),
          ButtonWidget(
            title: AppLocalizations.of(context)!.translate('backToLogin'),
            onTap: (){
              navigateToAndRemoveNamed(route: Routes.login);
            },
          )
        ],
      ),
    );
  }
}