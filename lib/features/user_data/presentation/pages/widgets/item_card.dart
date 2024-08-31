import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/text_widget.dart';

class ItemForCard extends StatelessWidget{
  final String text;
  final String? titleData;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const ItemForCard({super.key, required this.text, required this.titleData, this.leadingIcon, this.trailingIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: .5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.16),
            offset: const Offset(0,0),
            blurRadius: 12
          )
        ]
      ),
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
                text : text,
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black
                )
            ),
            TextWidget(
                text : titleData ?? "",
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp
                )
            ),
          ],
        ),
        trailing: Icon(trailingIcon),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }
}