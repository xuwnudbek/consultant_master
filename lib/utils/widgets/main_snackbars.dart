import 'package:consultant_orzu/pages/home/view/calculator/calculator_page.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainSnackbars {
  static success(String msg) {
    Get.closeAllSnackbars();
    return Get.snackbar(
      "success".tr,
      msg,
      titleText: Text(
        "success".tr,
        style: Get.textTheme.bodyLarge!.copyWith(color: HexToColor.light),
      ),
      messageText: Row(
        children: [
          Text(
            msg,
            style: Get.textTheme.bodyMedium!.copyWith(color: HexToColor.light),
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
      colorText: HexToColor.light,
      backgroundColor: HexToColor.greenColor,
      duration: Duration(milliseconds: 2000),
    );
  }

  static warning(String msg) {
    Get.closeAllSnackbars();

    return Get.snackbar(
      "warning".tr,
      msg,
      titleText: Text(
        "warning".tr,
        style: Get.textTheme.bodyLarge!.copyWith(color: HexToColor.light),
      ),
      messageText: Text(
        msg,
        style: Get.textTheme.bodyMedium!.copyWith(color: HexToColor.light),
      ),
      margin: EdgeInsets.all(20),
      colorText: HexToColor.light,
      backgroundColor: Colors.orange,
      duration: Duration(milliseconds: 2000),
    );
  }

  static error(String msg) {
    Get.closeAllSnackbars();
    return Get.snackbar(
      "error".tr,
      msg,
      titleText: Text(
        "error".tr,
        style: Get.textTheme.bodyLarge!.copyWith(color: HexToColor.light),
      ),
      messageText: Text(
        msg,
        style: Get.textTheme.bodyMedium!.copyWith(color: HexToColor.light),
      ),
      margin: EdgeInsets.all(20),
      colorText: HexToColor.light,
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 2000),
    );
  }
}
