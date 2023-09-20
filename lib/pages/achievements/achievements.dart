import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/pages/achievements/provider/achievements_provider.dart';
import 'package:consultant_orzu/pages/home/view/profile/provider/profile_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/profile_status_widget.dart';
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
                            ProfileStatusWidget(pd: pd),
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
