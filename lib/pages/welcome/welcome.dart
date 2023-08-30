import 'package:consultant_orzu/pages/auth/login/login.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isAnimate = false;
  Offset position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSize(
        duration: Duration(milliseconds: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/images/logo.svg"),
                          ),
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
                          Container(
                            width: Get.width * 0.7,
                            child: SvgPicture.asset(
                              "assets/images/assist.svg",
                              width: Get.width * 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
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
            ),
          ],
        ),
      ),
    );
  }
}
