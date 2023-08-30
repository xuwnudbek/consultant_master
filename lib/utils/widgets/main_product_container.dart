import 'package:consultant_orzu/controller/hive/hive.dart';
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
    this.width = 150,
    required this.onAddCalc,
    required this.onPressed,
  });

  Map? product;
  double width;
  Function onAddCalc;
  Function onPressed;

  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width, maxHeight: 300),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                    "${product!['title_${HiveService.get("language") ?? "uz"}']}",
                    style: TextStyle(
                      fontSize: 12.8.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  Spacer(),

                  /*
                        {
                            "id": 35,
                            "category_id": 196,
                            "slug": "redmi-10-qdwdqw",
                            "article": "asdasdA",
                            "title_uz": "Redmi 10 qdwdqw",
                            "title_uzc": "Redmi 10 qwdqwd",
                            "title_ru": "Redmi 10 asdasd",
                            "short_description_uz": null,
                            "short_description_uzc": null,
                            "short_description_ru": null,
                            "price": 10000000,
                            "discount_price": 100,
                            "monthly_pay": null,
                            "is_discount": true,
                            "badges": [],
                            "tabs": [],
                            "image": "https://app.orzugrand.uz/storage/uploads/products/1683869189c3QA2xpOs6Ju8I4O.jpeg"
                        },
                      
                      
                      */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: product!['is_discount'],
                            child: Text(
                              "${product!['is_discount'] ? product!['discount_price'] : ""}  so'm",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12.8.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            "${product!['price'].truncate()} so'm",
                            style: TextStyle(
                              fontSize: 13.7.sp,
                              fontWeight: FontWeight.w600,
                              color: HexToColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     onAddCalc(widgetKey);
                      //   },
                      //   child: Container(
                      //     // color: Colors.red,
                      //     child: SvgPicture.asset(
                      //       "assets/images/calc.svg",
                      //       height: 18.sp,
                      //       width: 18.sp,
                      //       color: HexToColor.mainColor,
                      //     ),
                      //   ),
                      // )
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
