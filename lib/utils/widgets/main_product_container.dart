import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class MainProductContainer extends StatelessWidget {
  MainProductContainer({
    super.key,
    this.product,
    required this.onAddCalc,
    required this.onPressed,
  });

  Map? product;
  Function onAddCalc;
  Function onPressed;

  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 0.3;

    return Container(
      constraints: BoxConstraints(maxWidth: width, maxHeight: Get.height * 0.27),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: shadowContainer(),
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${product!['article']}",
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Expanded(
                flex: 4,
                child: Container(
                  key: widgetKey,
                  child: ImageNetwork(
                    "${product!['image']}",
                    imgFit: BoxFit.fitWidth,
                  ),
                )),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "${product!['title_${Get.locale!.countryCode ?? "uz"}']}",
                    style: TextStyle(
                      fontSize: 12.8.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: product!['is_discount'] ?? false,
                            child: Text(
                              "${MainFunc().prettyPrice(product!['price'])} ${"sum".tr}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12.8.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: product!['is_discount'] ?? false,
                            child: Text(
                              "${MainFunc().prettyPrice(product!['discount_price'] ?? 0)} ${"sum".tr}",
                              style: TextStyle(
                                fontSize: 13.7.sp,
                                fontWeight: FontWeight.w600,
                                color: HexToColor.mainColor,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !(product!['is_discount'] ?? false),
                            child: Text(
                              "${MainFunc().prettyPrice(product!['price'])} ${"sum".tr}",
                              style: TextStyle(
                                fontSize: 13.7.sp,
                                fontWeight: FontWeight.w600,
                                color: HexToColor.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
