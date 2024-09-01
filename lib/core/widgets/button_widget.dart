import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_constatnts/global.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double width;
  final String? pathImage;

  const ButtonWidget({super.key,
    required this.title,
    this.onTap,
    this.width = double.infinity,
    this.pathImage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 48.h,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(pathImage != null)...[
              SvgPicture.asset(pathImage!),
              SizedBox(width: 6.w,),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp
              ),
            ),
          ],
        ),
      ),
    );
  }
}
