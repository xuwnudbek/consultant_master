import 'package:consultant_orzu/pages/about_product/provider/about_product_provider.dart';
import 'package:consultant_orzu/pages/about_product/about_product.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/numeric_text_formatter/numeric_text_formatter.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomSheetX extends StatelessWidget {
  BottomSheetX({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<AboutProductProvider>(builder: (context, provider, _) {
      return Visibility(
        visible: !provider.isLoading,
        child: Container(
          width: Get.width,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          constraints: BoxConstraints(maxHeight: 80, minHeight: 75),
          // margin: EdgeInsets.only(top: 50 / 2),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 3,
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: boxDecoration.copyWith(color: HexToColor.mainColor.withOpacity(0.9)),
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 15),
                      Text(
                        "${MainFunc().prettyPrice(provider.bottomPrice * provider.bottomCount)} ${"sum".tr}",
                        style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                      ),
                      DecoratedBox(
                        decoration: boxDecoration.copyWith(
                          color: HexToColor.mainColor.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5,
                              blurStyle: BlurStyle.inner,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.bottomDec();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "${provider.bottomCount}",
                                    style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  provider.bottomInc();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              SizedBox(width: 15),

              ///Button
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    //Rasmiylashtirish
                    if (provider.bottomCount == 0) {
                      MainSnackbars.warning("at_least_1_product".tr);
                      return;
                    }

                    if (provider.isFormalizating) return;
                    provider.dateController.clear();
                    provider.initPriceController.clear();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return _buildDialog(
                          provider: provider,
                          onSend: () async {
                            provider.formalization();
                            Get.back();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: boxDecoration.copyWith(color: HexToColor.mainColor),
                    child: Text(
                      "add_to_cart".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: HexToColor.greyTextFieldColor,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 0.1,
        blurRadius: 3,
      ),
    ],
  );

  //make dialog for formalization with phone number
}

AlertDialog _buildDialog({required AboutProductProvider provider, required Function onSend}) {
  var allPrice = provider.bottomPrice * provider.bottomCount;
  var pretPrice = MainFunc().prettyPrice(allPrice);
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "fill_all_data".tr,
          style: Get.textTheme.titleSmall,
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.clear,
            color: Colors.red,
            size: 48,
          ),
        ),
      ],
    ),
    content: Container(
      constraints: BoxConstraints(minWidth: 400),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 5, bottom: 10),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${"input_month".tr}: ", style: Get.textTheme.bodyLarge),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: provider.dateController,
                    onChanged: (value) {
                      if ((int.tryParse(value) ?? 0) <= 0) provider.dateController.clear();
                      if ((int.tryParse(value) ?? 0) > 12)
                        provider.dateController.value = TextEditingValue(
                          text: "12",
                          selection: TextSelection(
                            baseOffset: 2,
                            extentOffset: 2,
                          ),
                        );
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.left,
                    style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      hintText: "how_many_months".tr,
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 5, bottom: 10),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("initial_payment".tr + ":", style: Get.textTheme.bodyLarge),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: provider.initPriceController,
                    onChanged: (value) {
                      value = value.replaceAll(RegExp(r'[^0-9]'), "");
                      if ((int.tryParse(value) ?? 0) >= allPrice) {
                        provider.initPriceController.value = TextEditingValue(
                          text: "${MainFunc().prettyPrice(allPrice)}",
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: pretPrice.length),
                          ),
                        );
                      }
                      (provider.initPriceController.text);
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.left,
                    style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      hintText: "0",
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                    inputFormatters: [
                      NumericTextFormatter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      MaterialButton(
        minWidth: 100,
        onPressed: () {
          if (provider.dateController.text.isEmpty) {
            MainSnackbars.warning("month_must_be_filled".tr);
            return;
          }

          onSend();
        },
        child: Text(
          "send".tr,
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
        color: HexToColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      )
    ],
    actionsPadding: EdgeInsets.only(right: 20, bottom: 15),
  );
}
