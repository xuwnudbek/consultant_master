import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainFunc {
  String prettyPrice(num price) {
    price = price.truncate();
    return NumberFormat.decimalPattern("uz").format(price);
  }

  //Main Dialog
  AlertDialog mainDialog({
    required Widget title,
    required Widget content,
    required Function onConfirm,
  }) {
    return AlertDialog(
      title: title,
      content: content,
      contentPadding: EdgeInsets.all(15),
      actions: [
        MaterialButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "no".tr,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            onConfirm();
          },
          child: Text("yes".tr),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
