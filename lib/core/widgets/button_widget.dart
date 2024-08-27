import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_constatnts/global.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final void Function()? onTap;
  final double width;
  final String? pathImage;

  const ButtonWidget({super.key,
    required this.title,
    required this.hasBorder,
    this.onTap,
    this.width = double.infinity,
    this.pathImage
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Global.white : Global.mediumBlue,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: Global.mediumBlue,
                  width: 1.0,
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: SizedBox(
          height: 48.0,
          width: width,
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
                  style: TextStyle(
                    color: hasBorder ? Global.mediumBlue : Global.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
