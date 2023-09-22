import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/pages/home/view/profile/provider/profile_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileStatusWidget extends StatelessWidget {
  const ProfileStatusWidget({super.key, required this.pd});

  final ProfileProvider pd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: Get.height * 0.25,
      width: Get.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: shadowContainer(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: Get.width * 0.18,
                  width: Get.width * 0.18,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Get.width * 0.17,
                        width: Get.width * 0.17,
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(-180 / 360),
                          child: CurvedCircularProgressIndicator(
                            value: !(pd.sold / pd.orders).isNaN ? pd.sold / pd.orders : 0,
                            strokeWidth: 5,
                            animationDuration: Duration(seconds: 1),
                            backgroundColor: Colors.green.shade100,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: pd.seller['image'] != null
                            ? Image.network(
                                "${HttpService.images}${pd.seller['image']}",
                                fit: BoxFit.cover,
                                height: Get.width * 0.15,
                                width: Get.width * 0.15,
                              )
                            : Image.asset(
                                "assets/images/unknown.jpg",
                                width: Get.width * 0.15 - 20,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: Get.width * 0.18,
                          height: 17.5.sp,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "salesman".tr,
                              style: TextStyle(fontSize: 12.8.sp, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${pd.seller['name']} ${pd.seller['surname']}",
                        style: TextStyle(
                          fontSize: 14.8.sp,
                          fontWeight: FontWeight.w500,
                          color: HexToColor.mainColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "sale_status".trParams({
                          "dan": "${pd.orders}",
                          "ta": "${pd.sold}",
                        }),
                        style: TextStyle(
                          fontSize: 12.8.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          ...pd.seller['prizs'].map((e) {
                            return Container(
                              width: 45,
                              height: 45,
                              margin: EdgeInsets.only(right: 7),
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    spreadRadius: 0.1,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image.network(
                                  "${HttpService.images}${e['prize']['image'] ?? ""}",
                                  width: 20,
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "orders".tr,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    GradientText(
                      '${pd.orders}',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      radius: .4,
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      colors: [
                        // HexToColor.mainColor,
                        Color.fromARGB(179, 253, 198, 155),
                        Color.fromARGB(255, 255, 111, 0)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "waiting_order".tr,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    GradientText(
                      '${pd.waiting}',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      radius: .4,
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      colors: [
                        // HexToColor.mainColor,
                        Color.fromARGB(179, 253, 198, 155),
                        Color.fromARGB(255, 255, 111, 0)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "sold".tr,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    GradientText(
                      '${pd.sold}',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      radius: .4,
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      colors: [
                        // HexToColor.mainColor,
                        Color.fromARGB(179, 253, 198, 155),
                        Color.fromARGB(255, 255, 111, 0)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "denied".tr,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    GradientText(
                      '${pd.denied}',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      radius: .4,
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      colors: [Color.fromARGB(179, 253, 198, 155), Color.fromARGB(255, 255, 111, 0)],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
