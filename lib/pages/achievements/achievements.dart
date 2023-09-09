import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/pages/achievements/provider/achievements_provider.dart';
import 'package:consultant_orzu/pages/home/view/profile/provider/profile_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

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
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      leading: BackButton(),
                    ),
                    body: Stack(
                      children: [
                        Image.asset(
                          "assets/images/background.jpg",
                          height: Get.height * 0.25,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                        // Text("${pd.seller}"),
                        Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.12,
                              child: Center(
                                child: Text(
                                  "achievements".tr,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    color: HexToColor.mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                                                  turns: new AlwaysStoppedAnimation(-150 / 360),
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
                                                child: Image.network(
                                                  "${HttpService.images}${pd.seller['image']}",
                                                  height: Get.width * 0.15,
                                                  width: Get.width * 0.15,
                                                  fit: BoxFit.cover,
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
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
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
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(1.0),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(100.0),
                                                            child: Image.network(
                                                              "${HttpService.images}${e['prize']['image']}",
                                                              fit: BoxFit.contain,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
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
                                                fontSize: 14.8.sp,
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
                                              "sold".tr,
                                              style: TextStyle(
                                                fontSize: 14.8.sp,
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
                                                fontSize: 14.8.sp,
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
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                                child: GridView.custom(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1.7,
                                  ),
                                  childrenDelegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return AchieveCard(achieve: pd.seller['prizs'][index]);
                                    },
                                    childCount: pd.seller['prizs'].length,
                                  ),
                                ),
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

class AchieveCard extends StatelessWidget {
  const AchieveCard({super.key, required this.achieve});

  final Map achieve;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: HexToColor.light,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 7,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                "${HttpService.images}${achieve['prize']['image']}",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: Get.width * 0.35,
                    child: Text(
                      "${achieve['prize']['title']}",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textScaleFactor: 0.95,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Text(
                          "${achieve['prize']['description']}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 0.8,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
