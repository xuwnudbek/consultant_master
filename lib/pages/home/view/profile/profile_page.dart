import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/pages/achievements/achievements.dart';
import 'package:consultant_orzu/pages/change_language/change_language.dart';
import 'package:consultant_orzu/pages/home/view/profile/change_profile.dart';
import 'package:consultant_orzu/pages/home/view/profile/provider/profile_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_button.dart';
import 'package:consultant_orzu/utils/widgets/profile_status_widget.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) => ProfileProvider(),
      builder: (context, snapshot) {
        return Consumer<ProfileProvider>(
          builder: (context, pd, _) {
            return pd.isLoading
                ? CPIndicator()
                : Scaffold(
                    body: Stack(
                      children: [
                        Image.asset(
                          "assets/images/background.jpg",
                          height: Get.height * 0.2,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            Row(),
                            SizedBox(
                              height: Get.height * 0.08,
                              child: Center(
                                child: Text(
                                  "profile".tr,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    color: HexToColor.mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            ProfileStatusWidget(pd: pd),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView(
                                children: [
                                  //Personal Area
                                  GestureDetector(
                                    onTap: () async {
                                      var res = await Get.to(() => ChangeProfile(), transition: Transition.rightToLeft);
                                      pd.refresh();
                                    },
                                    child: Container(
                                      // height: 50,
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: shadowContainer(),
                                      ),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/images/profile_icon.svg",
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "personal_area".tr,
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.grey,
                                          size: 20,
                                        )
                                      ]),
                                    ),
                                  ),
                                  //Achievements
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => Achievements(), transition: Transition.rightToLeft);
                                    },
                                    child: Container(
                                      // height: 50,
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: shadowContainer(),
                                      ),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/images/achievement.svg",
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "achievements".tr,
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.grey,
                                          size: 20,
                                        )
                                      ]),
                                    ),
                                  ),
                                  //Language
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.to(() => ChangeLanguage(), transition: Transition.rightToLeft);
                                      pd.refresh();
                                    },
                                    child: Container(
                                      // height: 50,
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: shadowContainer(),
                                      ),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/images/language.svg",
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "${pd.language == "uz" ? "O'zbekcha" : "Русский"}",
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.grey,
                                          size: 20,
                                        )
                                      ]),
                                    ),
                                  ),
                                  //Logout
                                  SizedBox(height: 7),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: ListTile(
                                        dense: true,
                                        onTap: () async {
                                          Get.defaultDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: Colors.red,
                                                  ),
                                                  padding: EdgeInsets.all(30),
                                                  child: SvgPicture.asset(
                                                    "assets/images/logout.svg",
                                                    width: 90,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "really_quit".tr,
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MainButton(
                                                    width: 150,
                                                    color: Colors.black26,
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "no".tr,
                                                      style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  MainButton(
                                                    width: 150,
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      pd.logout();
                                                    },
                                                    child: Text(
                                                      "yes".tr,
                                                      style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        tileColor: Colors.red,
                                        leading: SvgPicture.asset(
                                          "assets/images/logout.svg",
                                          width: 30,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          "quit".tr,
                                          style: Get.textTheme.bodyLarge!.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
