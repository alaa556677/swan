import 'package:flutter/material.dart';
import '../../main.dart';

customShowSnackBar({bool isError = true, required String message}){
  snackBarKey.currentState?.showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    content: Text(message),
    duration: const Duration(seconds: 2),
  ));
}

