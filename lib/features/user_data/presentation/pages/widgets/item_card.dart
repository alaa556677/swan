import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swan/core/app_constatnts/global.dart';

import '../../../../../core/styles/theme/change_notifier.dart';
import '../../../../../core/widgets/text_widget.dart';

class ItemForCard extends StatelessWidget{
  final String text;
  final String? titleData;
  final IconData? leadingIcon;
  final TextStyle? textStyle;
  final Color valueColor;

  const ItemForCard({super.key, required this.text, required this.titleData, this.leadingIcon, this.textStyle, this.valueColor = Global.greyColor});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: .5.w),
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: Theme.of(context).iconTheme.color,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50.w,
              child: TextWidget(
                text : text,
                textStyle: themeNotifier.currentTheme == ThemeMode.light ? TextStyle(
                    fontSize: 15.sp,
                    color: Global.blackColor
                ): TextStyle(
                    fontSize: 15.sp,
                    color: Global.whiteColor
                )
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child :TextWidget(
                text : titleData ?? "",
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: valueColor,
                )
              ),
            ),
          ],
        ),
        // trailing: Icon(trailingIcon),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }
}