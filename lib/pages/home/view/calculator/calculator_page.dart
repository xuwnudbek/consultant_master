import 'package:consultant_orzu/pages/home/view/calculator/provider/calculator_provider.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/pop_dialog/pop_dialog.dart';
import 'package:consultant_orzu/utils/widgets/product_container/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                              Image.asset(
                                "assets/images/empty.png",
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Jin ursin, Qodirxon 😟 \nhali hech narsa tanlanmagan ",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyLarge,
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
                          visible: provider.save['products'].isNotEmpty,
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
                                        "${provider.countProducts} товара",
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600, fontSize: 14.8.sp),
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            "${MainFunc().prettyPrice(provider.allPrice)} сум",
                                            style: TextStyle(fontWeight: FontWeight.w600, color: HexToColor.mainColor, fontSize: 14.8.sp),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "${MainFunc().prettyPrice(provider.allDiscountPrice)} сум",
                                            style: TextStyle(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14.8.sp),
                                          ),
                                        ],
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
                                        "Офформление",
                                        style: TextStyle(fontSize: 12),
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
                                    Image.asset(
                                      "assets/images/empty.png",
                                      height: 150,
                                      width: 150,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Jin ursin, Qodirxon 😟 \nhali hech narsa tanlanmagan ",
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.bodyLarge,
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
                                              //First of all delete from list
                                              _animatedListKey.currentState!.removeItem(
                                                index,
                                                (context, animation) => Container(),
                                                duration: Duration(milliseconds: 700),
                                              );
                                              provider.onDeleteProduct(product['id']);
                                              //Then delete from animated list
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

//Custom Slider

class SliderX extends StatelessWidget {
  SliderX(this.onChange(value));

  Function onChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<SliderXProvider>(builder: (context, provider, _) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 2,
                activeTrackColor: HexToColor.mainColor,
                inactiveTrackColor: HexToColor.greyTextFieldColor,
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 7),
                activeTickMarkColor: HexToColor.mainColor,
                inactiveTickMarkColor: HexToColor.greyTextFieldColor,
                overlayColor: HexToColor.mainColor.withOpacity(.7),
                showValueIndicator: ShowValueIndicator.always,
                valueIndicatorColor: HexToColor.mainColor.withOpacity(1),
                thumbColor: HexToColor.mainColor,
              ),
              child: Slider(
                label: "${provider.value.truncate()}",
                value: provider.value * 1.0,
                onChanged: (value) {
                  onChange(value.toInt());
                  provider.value = value.toInt();
                },
                divisions: 9,
                min: 3,
                max: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...[3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((e) {
                    return Container(
                      alignment: Alignment.center,
                      width: 20,
                      child: Text(
                        "${(e % 3 == 0 || provider.value == e) ? e : ''}",
                        style: TextStyle(
                          color: (provider.value >= e) ? HexToColor.mainColor : HexToColor.greyTextFieldColor,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SliderXProvider extends ChangeNotifier {
  int _value = 3;
  int get value => _value;
  set value(int val) {
    _value = val;
    notifyListeners();
  }
}



/*
TextFormField(
  keyboardType: TextInputType.number,
  controller: provider.initPriceController,
  inputFormatters: [
    IntRangeTextInputFormatter(
      max: 100000000,
    ),
    NumericTextFormatter(),
  ],
  style: Theme.of(context).textTheme.bodyLarge,
  decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    hintText: "0",
    fillColor: HexToColor.greyTextFieldColor,
    errorStyle: TextStyle(fontSize: 0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: HexToColor.mainColor, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
  ),
),


*/
