import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final Color? fontColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? textDecoration;
  final Color? decorationColor;

  const TextWidget({
    required this.text,
    super.key,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    this.fontWeight,
    this.fontColor,
    this.fontFamily,
    this.fontSize,
    this.textDecoration,
    this.decorationColor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? TextStyle(
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: fontFamily,
          decoration: textDecoration,
          decorationColor: decorationColor
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
