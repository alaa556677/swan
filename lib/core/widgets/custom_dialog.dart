import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/widgets/text_widget.dart';
import '../app_constatnts/app_localization.dart';
import '../app_constatnts/global.dart';
import '../app_constatnts/navigate_methods.dart';
import '../app_constatnts/routes.dart';
import '../network/cache_helper.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          width: 300.w,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 10.w, top: 10.h),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                TextWidget(
                    text: AppLocalizations.of(context)!.translate('dialogQuestion'),
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Global.blackColor
                    )
                ),
                SizedBox(height: 22.h),
                const Divider(height: 0, color: Colors.grey),
                SizedBox(
                  height: 40.h,
                  child: Row(children: [
                    Expanded(
                        child: InkWell(
                          onTap: (){
                            CacheHelper.clearAllData();
                            navigateToAndRemoveNamed(route: Routes.login);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                            child: TextWidget(
                                text: AppLocalizations.of(context)!.translate('yes'),
                                textStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Global.blackColor
                                )
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))),
                            child: TextWidget(
                                text : AppLocalizations.of(context)!.translate('no'),
                                textStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Global.whiteColor
                                )
                            ),
                          ),
                        )),
                  ]),
                ),
              ]
          ),
        )
    );
  }
}

