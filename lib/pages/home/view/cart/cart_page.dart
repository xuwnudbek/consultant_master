import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:consultant_orzu/pages/about_cart/about_cart.dart';
import 'package:consultant_orzu/pages/home/view/cart/provider/cart_page_provider.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartPageProvider>(
      create: (context) => CartPageProvider(),
      child: Consumer<CartPageProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: provider.isLoading
                ? CPIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // SearchButtonField(controller: provider.searchController),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              "sale_history".tr,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: HexToColor.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  // Expanded(flex: 3, child: SizedBox()),
                                  Spacer(),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        iconStyleData: IconStyleData(
                                          icon: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        hint: Text(
                                          "    ${"category".tr}",
                                          style: TextStyle(fontSize: 13.8.sp, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                        barrierColor: HexToColor.mainColor.withOpacity(0.1),
                                        items: provider.listCategory.entries
                                            .map((item) => DropdownMenuItem<String>(
                                                  value: "${item.key}",
                                                  child: Text(
                                                    "    " + item.value,
                                                    style: TextStyle(color: Colors.white, fontSize: 13.8.sp, fontWeight: FontWeight.w500),
                                                  ),
                                                ))
                                            .toList(),
                                        value: provider.selectCategory,
                                        onChanged: provider.onSelectItem,
                                        buttonStyleData: ButtonStyleData(
                                          height: 44,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: HexToColor.mainColor,
                                          ),
                                          width: Get.width,
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          height: 24.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  InkWell(
                                    onTap: () async {
                                      final result = await showCalendarDatePicker2Dialog(
                                        context: context,
                                        config: CalendarDatePicker2WithActionButtonsConfig(
                                            calendarType: CalendarDatePicker2Type.range,
                                            selectedDayHighlightColor: HexToColor.mainColor,
                                            firstDate: DateTime(DateTime.now().year, DateTime.now().month - 2, DateTime.now().day),
                                            lastDate: DateTime.now(),
                                            controlsTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            dayBuilder: ({required date, textStyle, decoration, isSelected, isDisabled, isToday}) {
                                              Widget? dayWidget;

                                              return dayWidget;
                                            }),
                                        dialogSize: const Size(325, 400),
                                        borderRadius: BorderRadius.circular(15),
                                        dialogBackgroundColor: Colors.white,
                                      );
                                      print(result);
                                      if (result != null) {
                                        provider.setDateRange = result;
                                      } else {
                                        print("null");
                                      }
                                    },
                                    child: SvgPicture.asset("assets/images/calendar.svg"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //if sales is empty
                      Visibility(
                        visible: provider.sales.isEmpty,
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: provider.sales.isEmpty,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/empty_history.svg",
                                      height: 350,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "sale_empty".tr,
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //if sales is not empty
                      Visibility(
                        visible: provider.sales.isNotEmpty,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //List of sales
                                if (provider.sorted.isEmpty) ...[
                                  Padding(
                                    padding: EdgeInsets.only(top: 0.2.dp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("sale_empty".tr),
                                      ],
                                    ),
                                  ),
                                ],
                                ...provider.sorted.map(
                                  (e) => ContainerCardList(sale: e, cartProvider: provider),
                                ),
                                SizedBox(height: Get.height * 0.1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class ContainerCardList extends StatelessWidget {
  const ContainerCardList({
    super.key,
    required this.sale,
    required this.cartProvider,
  });

  final Map sale;
  final CartPageProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContainerCardListProvider>(
      create: (context) => ContainerCardListProvider(),
      child: Consumer<ContainerCardListProvider>(builder: (context, provider, child) {
        return SizedBox(
          height: 120,
          width: Get.width - 32,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // width: Get.width - 64,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              //Info
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: 0,
                bottom: 0,
                right: !provider.isAnimation ? 200 : 40,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => AboutCart(sale: sale), transition: Transition.rightToLeft);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade300,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //
              AnimatedPositioned(
                duration: Duration(milliseconds: provider.durationAnimation),
                right: provider.right,
                child: GestureDetector(
                  onTap: () {
                    provider.onAnimated();
                    print("onAnimate");
                  },
                  onHorizontalDragUpdate: (details) {
                    provider.onSwipe(details);
                  },
                  onHorizontalDragEnd: (details) {
                    provider.onUpdateEndSwipe();
                  },
                  child: Container(
                    height: 100,
                    width: Get.width - 32,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // padding: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: shadowContainer(),
                    ),
                    child: Row(children: [
                      Container(
                        width: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                          color: sale['status'] == "0"
                              ? Colors.blue.withOpacity(0.5)
                              : sale['status'] == "1"
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.red.withOpacity(0.5),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/text_icon.svg",
                            ),
                            SizedBox(height: 5),
                            Text(
                              "№${sale['id']}",
                              style: Get.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "goods_number".tr + ":",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${cartProvider.saleAllPrice[sale['id']]!['count']}",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: HexToColor.mainColor),
                                  ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "all_price".tr + ":",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "${MainFunc().prettyPrice(cartProvider.saleAllPrice[sale['id']]!['price'])} ${"sum".tr}",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: HexToColor.mainColor),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      Column(
                        children: [
                          Container(
                            height: 35,
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            decoration: BoxDecoration(
                              color: sale['status'] == "0"
                                  ? Colors.blue.withOpacity(0.8)
                                  : sale['status'] == "1"
                                      ? Colors.green.withOpacity(0.8)
                                      : Colors.red.withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(100),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${cartProvider.listCategory[sale['status']]}",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ContainerCardListProvider extends ChangeNotifier {
  bool isAnimation = false;
  double right = 0;
  int durationAnimation = 300;
  void onAnimated() {
    isAnimation = !isAnimation;
    durationAnimation = 300;
    if (isAnimation) {
      right = 120;
    } else {
      right = 0;
    }

    notifyListeners();
  }

  void onSwipe(value) {
    durationAnimation = 0;
    right = max(0, right + ((-1) * value.delta.dx));
    notifyListeners();
  }

  void onUpdateEndSwipe() {
    durationAnimation = 300;
    if (right > 50) {
      right = 100;
      isAnimation = true;
    } else {
      right = 0;
      isAnimation = false;
    }
    notifyListeners();
  }
}
