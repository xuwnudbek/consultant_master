import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/pages/about_product/provider/about_product_provider.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/numeric_text_formatter/numeric_text_formatter.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/calculator_form/calculator_form.dart';
import 'package:consultant_orzu/utils/widgets/carousel_slider_indicator.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                                      child: CarouselSlider(
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
                                      child: CarouselSliderIndicator(
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
                                                  provider.product?.isDiscount
                                                      ? Text(
                                                          "${MainFunc().prettyPrice(provider.product?.discountPrice)} сум",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 13.8.sp,
                                                            color: Colors.grey.shade700,
                                                            decoration: TextDecoration.lineThrough,
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                  Text(
                                                    "${MainFunc().prettyPrice(provider.product?.price)} ${"sum".tr}",
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.8.sp),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${"article".tr}: ${provider.product?.article}",
                                                // "Артикул: 20033451",
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
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    "При покупке",
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.8.sp),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                //   spacing: 0.0,
                                                //   runSpacing: 0,
                                                children: [
                                                  //Features

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
                      CalculatorForm(price: provider.product!.price),
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
                "Часто задаваемые вопросы:",
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
                // tilePadding: EdgeInsets.symmetric(),
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

class BottomSheetX extends StatelessWidget {
  BottomSheetX({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<AboutProductProvider>(builder: (context, provider, _) {
      return Visibility(
        visible: !provider.isLoading,
        child: Container(
          width: Get.width,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          constraints: BoxConstraints(maxHeight: 80, minHeight: 75),
          // margin: EdgeInsets.only(top: 50 / 2),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 3,
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: boxDecoration.copyWith(color: HexToColor.mainColor.withOpacity(0.9)),
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 15),
                      Text(
                        "${MainFunc().prettyPrice(provider.bottomPrice * provider.bottomCount)} ${"sum".tr}",
                        style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                      ),
                      DecoratedBox(
                        decoration: boxDecoration.copyWith(
                          color: HexToColor.mainColor.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5,
                              blurStyle: BlurStyle.inner,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  provider.bottomDec();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "${provider.bottomCount}",
                                    style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  provider.bottomInc();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              SizedBox(width: 15),

              ///Button
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    //Rasmiylashtirish
                    if (provider.bottomCount == 0) return;
                    if (provider.isFormalizating) return;
                    provider.dateController.clear();
                    provider.initPriceController.clear();

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return _buildDialog(
                          provider: provider,
                          onSend: () async {
                            print("binnima bosildi");
                            provider.formalization();
                            Get.back();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: boxDecoration.copyWith(color: HexToColor.mainColor),
                    child: Text(
                      "add_to_cart".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: HexToColor.greyTextFieldColor,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 0.1,
        blurRadius: 3,
      ),
    ],
  );

  //make dialog for formalization with phone number
}

AlertDialog _buildDialog({required AboutProductProvider provider, required Function onSend}) {
  var allPrice = provider.bottomPrice * provider.bottomCount;
  var pretPrice = MainFunc().prettyPrice(allPrice);
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Malumotlarni to'ldiring",
          style: Get.textTheme.titleSmall,
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.clear,
            color: Colors.red,
            size: 48,
          ),
        ),
      ],
    ),
    content: Container(
      constraints: BoxConstraints(minWidth: 400),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 5, bottom: 10),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${"input_month".tr}: ", style: Get.textTheme.bodyLarge),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: provider.dateController,
                    onChanged: (value) {
                      if ((int.tryParse(value) ?? 0) <= 0) provider.dateController.clear();
                      if ((int.tryParse(value) ?? 0) > 12)
                        provider.dateController.value = TextEditingValue(
                          text: "12",
                          selection: TextSelection(
                            baseOffset: 2,
                            extentOffset: 2,
                          ),
                        );
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.left,
                    style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      hintText: "Nechi oyga bo'lib to'lamoqchisiz?",
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                    inputFormatters: [],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 5, bottom: 10),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Boshlangich to'lov: ", style: Get.textTheme.bodyLarge),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: provider.initPriceController,
                    onChanged: (value) {
                      value = value.replaceAll(RegExp(r'[^0-9]'), "");
                      if ((int.tryParse(value) ?? 0) >= allPrice) {
                        provider.initPriceController.value = TextEditingValue(
                          text: "${MainFunc().prettyPrice(allPrice)}",
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: pretPrice.length),
                          ),
                        );
                      }
                      print(provider.initPriceController.text);
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.left,
                    style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      hintText: "Boshlang'ich to'lov qilasizmi?",
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                    inputFormatters: [
                      NumericTextFormatter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      MaterialButton(
        minWidth: 100,
        onPressed: () {
          if (provider.dateController.text.isEmpty) {
            MainSnackbars.warning("month_must_be_filled".tr);
            return;
          }

          onSend();
        },
        child: Text(
          "send".tr,
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
        color: HexToColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      )
    ],
    actionsPadding: EdgeInsets.only(right: 20, bottom: 15),
  );
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
              feature['family_title_${HiveService.get("language")}'],
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
