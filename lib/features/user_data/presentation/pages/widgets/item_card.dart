import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/global.dart';

import '../../../../../core/widgets/text_widget.dart';

class ItemForCard extends StatelessWidget{
  final String text;
  final String? titleData;
  final IconData? leadingIcon;

  const ItemForCard({super.key, required this.text, required this.titleData, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
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
            TextWidget(
              text : text,
              textStyle: Theme.of(context).textTheme.bodySmall
            ),
            TextWidget(
              text : titleData ?? "",
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Global.greyColor
              )
            ),
          ],
        ),
        // trailing: Icon(trailingIcon),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }
}