import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/loaders/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductContainer extends StatefulWidget {
  ProductContainer({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onChangeCount,
    this.canChangeCount = true,
    this.canDelete = true,
  });
  Map product;
  Function onDelete;
  Function onChangeCount;
  bool canChangeCount;
  bool canDelete;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.addListener(() {
      if (_controller.isCompleted)
        _controller.reverse().then((value) {
          _controller.forward();
        });
    });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isAnimation = false;
  bool showDetails = false;
  bool showPriceContainer = false;
  bool isChangingCount = false;

  int animatedMain = 200;
  double animatedHeight = 120;

  showDetailsTile() async {
    print("showDetailsTile");
    setState(() {
      Future.delayed(Duration(milliseconds: 250)).then((value) {
        setState(() => showPriceContainer = !showPriceContainer);
      });
      showDetails = !showDetails;
      if (showDetails) {
        animatedHeight = 250;
      } else {
        animatedHeight = 120;
      }
    });
  }

  void onSwipe() {
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    var product = widget.product;
    var data = product['data'];

    // print(;
    print(product);

    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: animatedHeight, //120
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(),
            ),
            // Details Container
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: 0,
              top: showDetails ? 130 : 0,
              bottom: 0,
              right: 0,
              curve: Curves.linear,
              child: Container(
                width: Get.width,
                height: 130,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 450),
                            left: showPriceContainer ? 0 : -(Get.width) / 2,
                            top: 12.5,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/cube.svg',
                                  // color: Colors.red,
                                  width: 40,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Сумма товара:",
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${MainFunc().prettyPrice(data['price'] * product['count'])} ${'sum'.tr}",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 10),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 550),
                            left: showPriceContainer ? 0 : -(Get.width) / 2,
                            top: 65,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/calendar-tick.svg',
                                  // color: Colors.red,
                                  width: 40,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Рассрочка на: ${product['date']} мес",
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 400),
                              right: showPriceContainer ? 0 : -(Get.width) / 2,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                height: 90,
                                width: Get.width / 2 - 85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                  ),
                                  color: Colors.white.withOpacity(0.90),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/coin.svg',
                                      width: 40,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${MainFunc().prettyPrice(data['price'] * product['count'] / int.parse(product['date'] ?? "1"))} ${'sum'.tr}",
                                      // "${MainFunc().prettyPrice(data['price'] / int.parse(product['date']))} сум / мес",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                        color: Colors.green,
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
                  ],
                ),
              ),
            ),

            //Main background Container
            Container(
              height: 120, //120
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(begin: Offset(-0.3, 0), end: Offset(0, 0)).animate(_controller),
                    child: SvgPicture.asset(
                      "assets/images/delete.svg",
                      color: Colors.red,
                      height: 20.sp,
                      width: 20.sp,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "delete".tr,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),

            //Products container
            AnimatedPositioned(
              duration: Duration(milliseconds: animatedMain),
              right: 0,
              bottom: 0,
              top: 0,
              left: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => showDetailsTile(),
                    child: Dismissible(
                      onUpdate: (details) {
                        //if canDelete is false then return
                        if (!widget.canDelete) return;
                      },
                      key: Key("${product}"),
                      direction: !widget.canDelete ? DismissDirection.none : DismissDirection.endToStart,
                      dismissThresholds: {DismissDirection.endToStart: 0.8},
                      onDismissed: (direction) {
                        onSwipe();
                      },
                      child: Container(
                        width: Get.width,
                        height: 120,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: shadowContainer(),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                "${data['image']}",
                                height: 32.sp,
                                width: 32.sp,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${data['title_${HiveService.get('language')}']}",
                                          maxLines: 2,
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                !data['is_discount']
                                                    ? SizedBox.shrink()
                                                    : Text(
                                                        "${MainFunc().prettyPrice(data['discount_price'] ?? 0)} ${'sum'.tr}",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                      ),
                                                Text(
                                                  "${MainFunc().prettyPrice(data['price'])} ${'sum'.tr}",
                                                  maxLines: 2,
                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                    fontSize: 15.5.sp,
                                                    color: HexToColor.mainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Visibility(
                                            //   visible: product['count'] > 1,
                                            //   child: Row(
                                            //     children: [
                                            //       Container(
                                            //         margin: const EdgeInsets.symmetric(horizontal: 10),
                                            //         height: 30,
                                            //         color: Colors.grey,
                                            //         width: 1.5,
                                            //       ),
                                            //       Text(
                                            //         "${MainFunc().prettyPrice(data['price'] * product['count'])} ${'sum'.tr}",
                                            //         maxLines: 2,
                                            //         style: TextStyle(
                                            //           fontWeight: FontWeight.w600,
                                            //           color: Colors.grey.shade700,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${data['article']}",
                                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 22.sp,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(20)),
                                          child: !widget.canChangeCount
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    // Text(
                                                    //   "count".tr,
                                                    //   style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
                                                    // ),
                                                    Text(
                                                      "${product['count']} ",
                                                      style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    //decrement
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (product['count'] == 1) return;

                                                        setState(() {
                                                          isChangingCount = true;
                                                        });

                                                        await widget.onChangeCount(product['id'], product['count'] - 1).then((value) {});
                                                        setState(() {
                                                          isChangingCount = false;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 18.sp,
                                                      ),
                                                    ),
                                                    isChangingCount
                                                        ? SizedBox(
                                                            width: 25,
                                                            child: LoadingIndicator(
                                                              color: HexToColor.mainColor,
                                                              size: 20,
                                                            ),
                                                          )
                                                        : Text(
                                                            "${product['count']}",
                                                            style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
                                                          ),
                                                    //increment
                                                    GestureDetector(
                                                      onTap: () async {
                                                        setState(() {
                                                          isChangingCount = true;
                                                        });
                                                        await widget.onChangeCount(product['id'], product['count'] + 1).then((value) {
                                                          print("");
                                                        });
                                                        setState(() {
                                                          isChangingCount = false;
                                                        });
                                                      },
                                                      child: Icon(Icons.add, size: 18.sp),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildCell(String value, {Color? color = Colors.green}) {
    return Container(
      height: 40,
      // margin: EdgeInsets.symmetric(horizontal: .5, vertical: .8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color ?? Colors.green)),
        color: color,
      ),
      child: Center(
        child: Text(
          "$value",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
