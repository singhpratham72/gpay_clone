import 'package:flutter/material.dart';
import 'package:gpay_clone/constants/colors.dart';

class SnackbarAlert {
  void basicSnackbar(
      {required BuildContext context, required String message}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ApplicationColors.scaffoldGrey,
        elevation: 0.0,
        behavior: SnackBarBehavior.fixed,
        content: Text(
          message,
          style: const TextStyle(color: ApplicationColors.black),
        )));
  }
}
