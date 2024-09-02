import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swan/core/app_constatnts/global.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.label,
    required this.controller,
    super.key,
    this.validator,
    this.keyboardType,
    this.onChange,
    this.isEnabled,
    this.onFieldSubmitted,
    this.errorState = false,
    this.fillColor,
    this.isPasswordVisible = false,
    this.suffix,
    this.prefix,
    this.onPressedSuffix
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool? isEnabled;
  final bool? errorState;
  final Color? fillColor;
  final bool isPasswordVisible;
  final Widget? suffix;
  final Widget? prefix;
  final void Function()? onPressedSuffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordVisible,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      enabled: isEnabled,
      style: const TextStyle(
        color: Global.mediumBlueLight
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14
        ),
        filled: true,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 12),
        helperStyle: TextStyle(height: .3.h,),
        helperText: "",
        errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Colors.red,
            height: 1
        ),
        suffixIcon: suffix ?? const SizedBox.shrink(),
        prefixIcon: prefix ?? const SizedBox.shrink(),
        floatingLabelStyle: const TextStyle(fontSize: 18),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red)) ,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red))),
    );
  }
}
