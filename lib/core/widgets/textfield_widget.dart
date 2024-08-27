import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_constatnts/global.dart';
import '../app_constatnts/home_model.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final dynamic onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFieldWidget({super.key,
    required this.hintText,
    required this.prefixIconData,
    this.suffixIconData,
    required this.obscureText,
    this.onChanged,
    required this.controller,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Global.mediumBlue,
      validator: validator,
      controller: controller,
      style: const TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Global.mediumBlue),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Global.mediumBlue,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 18,
            color: Global.mediumBlue,
          ),
        ),
      ),
    );
  }
}
