import 'package:expense_tracker_lite/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToast(String error) async {
  await Fluttertoast.cancel();
  await Fluttertoast.showToast(
    msg: error,
    backgroundColor: Colors.red,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
  );
}

Future<void> showSuccess(String message) async {
  await Fluttertoast.cancel();
  await Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColors.primaryColor,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
  );
}
