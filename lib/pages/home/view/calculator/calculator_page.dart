import 'package:consultant_orzu/pages/home/view/calculator/provider/calculator_provider.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/pop_dialog/pop_dialog.dart';
import 'package:consultant_orzu/utils/widgets/product_container/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({super.key});

  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (context) => CalculatorProvider(),
      builder: (context, snapshot) {
        return Consumer<CalculatorProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? CPIndicator()
                : provider.save.isEmpty
                    ? Center(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/empty.svg",
                                height: 350,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "empty_calculator".tr,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          title: Row(
                            children: [
                              Text(
                                "calculator".tr,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: HexToColor.light,
                          shadowColor: Colors.grey.shade100,
                          elevation: 3,
                          toolbarHeight: 70,
                        ),
                        extendBody: true,
                        //Bottom navbar
                        bottomNavigationBar: Visibility(
                          visible: provider.save.isNotEmpty && provider.save['products'].isNotEmpty,
                          child: Container(
                            height: Get.height * 0.1,
                            width: 200,
                            margin: EdgeInsets.only(bottom: 32.sp, left: 16, right: 16),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: shadowContainer(),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${"count_products".tr} :  ${provider.countProducts}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        "${"all".tr}:  ${MainFunc().prettyPrice(provider.allPrice - provider.allInitialPrice)} ${"sum".tr}",
                                        style: TextStyle(fontWeight: FontWeight.w600, color: HexToColor.mainColor, fontSize: 14.8.sp),
                                      ),
                                      Visibility(
                                        visible: provider.allInitialPrice != 0,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "initial_payment".tr + ":  ",
                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                color: Colors.grey.shade600,
                                                fontSize: 13.5.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${MainFunc().prettyPrice(provider.allInitialPrice)} ${"sum".tr}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        provider.deleteSave();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.white,
                                        ),
                                        decoration: BoxDecoration(color: HexToColor.mainColor, borderRadius: BorderRadius.circular(4)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(HexToColor.mainColor),
                                      ),
                                      onPressed: () async {
                                        var res = await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return PopDialog(
                                              onSend: (value) {
                                                provider.oformit(value);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        "oformit".tr,
                                        style: Get.textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: provider.save['products'].isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/empty.svg",
                                      height: 350,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "empty_calculator".tr,
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  //Products
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: AnimatedList(
                                        key: _animatedListKey,
                                        initialItemCount: provider.save['products'].length,
                                        itemBuilder: (context, index, animation) {
                                          Map product = provider.save['products'][index];
                                          return ProductContainer(
                                            key: Key("${product['id']}"),
                                            product: product,
                                            onChangeCount: provider.onChangeCount,
                                            onDelete: () {
                                              _animatedListKey.currentState!.removeItem(
                                                index,
                                                (context, animation) => Container(),
                                                duration: Duration(milliseconds: 700),
                                              );
                                              provider.onDeleteProduct(product['id']);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.185),
                                ],
                              ),
                      );
          },
        );
      },
    );
  }
}
