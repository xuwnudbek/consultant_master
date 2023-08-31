import 'package:consultant_orzu/pages/auth/login/login.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/logo.svg"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  "welcome".tr,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "convenience_with_us".tr,
                  style: Theme.of(Get.context!).textTheme.bodyLarge,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: Get.width * 0.7,
                  child: SvgPicture.asset(
                    "assets/images/assist.svg",
                    width: Get.width * 0.5,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: Get.width * 0.6,
                  child: MainButton(
                    onPressed: () {
                      Get.to(() => Login(), transition: Transition.rightToLeft);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "login".tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: HexToColor.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
