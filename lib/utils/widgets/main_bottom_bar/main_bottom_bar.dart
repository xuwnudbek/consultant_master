import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/main_bottom_bar/provider/main_bottom_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainBottomBar extends StatelessWidget {
  MainBottomBar({
    super.key,
    required this.onPressed,
  });
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBottomBarProvider>(
      create: (context) => MainBottomBarProvider(),
      child: Consumer<MainBottomBarProvider>(builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 30.sp,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 40,
                bottom: 0,
              ),
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
                boxShadow: shadowContainer(),
              ),
              child: Row(
                children: [
                  MainBottomBarItem(
                    active: provider.itemSelect == 0,
                    onTap: () {
                      provider.onPressed(0);
                      onPressed(0);
                    },
                    title: "home".tr,
                    icon: "assets/images/home.svg",
                  ),
                  MainBottomBarItem(
                    active: provider.itemSelect == 1,
                    onTap: () {
                      provider.onPressed(1);
                      onPressed(1);
                    },
                    title: "category".tr,
                    icon: "assets/images/search.svg",
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  MainBottomBarItem(
                    active: provider.itemSelect == 3,
                    onTap: () {
                      provider.onPressed(3);
                      onPressed(3);
                    },
                    title: "sale_history".tr,
                    icon: "assets/images/cart.svg",
                  ),
                  MainBottomBarItem(
                    active: provider.itemSelect == 4,
                    onTap: () {
                      provider.onPressed(4);
                      onPressed(4);
                    },
                    title: "profile".tr,
                    icon: "assets/images/user.svg",
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 25.sp,
                backgroundColor: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    provider.onPressed(2);
                    onPressed(2);
                  },
                  child: CircleAvatar(
                    radius: 23.sp,
                    backgroundColor: HexToColor.mainColor.withOpacity(0.4),
                    child: CircleAvatar(
                      radius: 21.sp,
                      backgroundColor: HexToColor.mainColor,
                      child: SvgPicture.asset(
                        "assets/images/calc.svg",
                        height: 20.sp,
                        width: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class MainBottomBarItem extends StatelessWidget {
  MainBottomBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.active,
    required this.onTap,
  });
  String title;
  String icon;
  bool active;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.sp),
        onTap: () => onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              icon,
              color: active ? HexToColor.mainColor : Colors.grey,
              height: 18.sp,
              width: 18.sp,
            ),
            Text(
              title,
              style: TextStyle(color: active ? HexToColor.mainColor : Colors.grey, fontSize: 13.sp, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
