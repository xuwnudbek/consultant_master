import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/pages/about_product/provider/about_product_provider.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/numeric_text_formatter/numeric_text_formatter.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/bottom_sheet_x/bottom_sheet_x.dart';
import 'package:consultant_orzu/utils/widgets/calculator_form/calculator_form.dart';
import 'package:consultant_orzu/utils/widgets/carousel_slider_indicator.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutProduct extends StatelessWidget {
  AboutProduct({super.key, required this.slug});

  String slug;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AboutProductProvider>(
      create: (context) => AboutProductProvider(slug: slug),
      child: Consumer<AboutProductProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
          ),
          bottomNavigationBar: BottomSheetX(),
          resizeToAvoidBottomInset: true,
          extendBody: true,
          body: provider.isLoading || provider.isFormalizating
              ? CPIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        constraints: BoxConstraints(
                          maxHeight: Get.height * 0.3,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: Get.height,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: shadowContainer(),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: provider.product?.images.length == 1
                                          ? Image.network(
                                              "${provider.product?.images[0].image}",
                                            )
                                          : CarouselSlider(
                                              options: CarouselOptions(
                                                autoPlay: true,
                                                enlargeCenterPage: true,
                                                enableInfiniteScroll: true,
                                                autoPlayCurve: Curves.easeIn,
                                                scrollDirection: Axis.horizontal,
                                                aspectRatio: 0.6,
                                                onPageChanged: (index, reason) {
                                                  provider.changeCaruselIndex = index;
                                                },
                                              ),
                                              items: [
                                                for (var img in provider.product?.images)
                                                  Image.network(
                                                    "${img.image}",
                                                  ),
                                              ],
                                            ),
                                    ),
                                    Expanded(
                                      child: provider.product?.images.length == 1
                                          ? SizedBox.shrink()
                                          : CarouselSliderIndicator(
                                              list: provider.product?.images.map((e) => {}).toList().cast<Map>(),
                                              position: provider.imageCaruselIndex,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //About Product
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                margin: EdgeInsets.only(left: 5, right: 16, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: shadowContainer(),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${provider.product?.titleUz}",
                                            // "Холодильник Samsung RT32FAJBDWW MSSF9000",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.8.sp,
                                            ),
                                          ),
                                          Wrap(
                                            spacing: 68,
                                            runSpacing: 0,
                                            crossAxisAlignment: WrapCrossAlignment.end,
                                            direction: Axis.horizontal,
                                            runAlignment: WrapAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible: provider.product?.isDiscount,
                                                    child: Text(
                                                      "${MainFunc().prettyPrice(provider.product?.price)} ${"sum".tr}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13.8.sp,
                                                        color: Colors.grey.shade700,
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: provider.product?.isDiscount,
                                                    child: Text(
                                                      "${MainFunc().prettyPrice(provider.product?.discountPrice ?? 0)} ${'sum'.tr}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.8.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: !provider.product?.isDiscount,
                                                    child: Text(
                                                      "${MainFunc().prettyPrice(provider.product?.price)} ${"sum".tr}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.8.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${"article".tr}: ${provider.product?.article}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.8.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 0.5,
                                            color: Colors.grey.shade400,
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.badges.isEmpty,
                                      child: Expanded(child: SizedBox.shrink()),
                                    ),
                                    Visibility(
                                      visible: provider.badges.isNotEmpty,
                                      child: Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "when_buying".tr,
                                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.8.sp),
                                                    ),
                                                  ],
                                                ),
                                                Wrap(
                                                  children: [
                                                    ...provider.badges.map((badge) {
                                                      return Container(
                                                        margin: EdgeInsets.only(right: 5, top: 10),
                                                        // height: 40,
                                                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey.shade400),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Tooltip(
                                                          triggerMode: TooltipTriggerMode.tap,
                                                          message: badge['tooltip_text_${HiveService.get("language")}'].toString(),
                                                          child: Text("${badge['name']}"),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: provider.features.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "features".tr,
                                style: Get.textTheme.titleSmall,
                              ),
                              SizedBox(height: 10),
                              ...provider.features.map((item) {
                                return InfoWidget(feature: item);
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: provider.questions.isNotEmpty,
                        child: _buildRareQuestions(provider.questions),
                      ),
                      SizedBox(height: 10),

                      ///Calculator
                      CalculatorForm(
                        price: provider.product!.isDiscount ? provider.product!.discountPrice : provider.product!.price,
                      ),
                      SizedBox(height: 110),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget _buildRareQuestions(List questions) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Text(
                "faq".tr + ":",
                style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        ...questions.map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: shadowContainer(),
              ),
              child: ExpansionTile(
                iconColor: HexToColor.mainColor,
                textColor: HexToColor.mainColor,
                collapsedIconColor: HexToColor.mainColor,
                initiallyExpanded: false,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                onExpansionChanged: (value) {},
                title: Text(
                  '${e['question']}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.8.sp),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '${e['response']}',
                      style: TextStyle(fontSize: 14.8.sp),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

////
class InfoWidget extends StatelessWidget {
  InfoWidget({super.key, this.feature});
  var feature;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              feature['family_title_${Get.locale!.languageCode}'],
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        Column(
          children: feature['data'].map<Widget>((e) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    e['group_title_${HiveService.get("language")}'],
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FDottedLine(
                      color: Colors.grey,
                      width: 100.0,
                      strokeWidth: 1.0,
                      dottedLength: 4.0,
                      space: 2.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    e['feature_name_${HiveService.get("language")}'],
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                  )
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
