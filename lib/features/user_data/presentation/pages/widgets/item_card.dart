import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/text_widget.dart';

class ItemForCard extends StatelessWidget{
  final String text;
  final String? titleData;
  final TextDecoration? decoration;
  final Color color;
  final double width;
  const ItemForCard({super.key, required this.text, required this.titleData, this.decoration, this.color = Colors.black, this.width = 80});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 2.h),
      child: Row(
        children: [
          SizedBox(
            width: width,
            child: TextWidget(
              text : text,
              textStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.black
              )
            ),
          ),
          Expanded(
            child: TextWidget(
              text : titleData ?? "",
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp
              )
            ),
          ),
        ],
      ),
    );
  }
}