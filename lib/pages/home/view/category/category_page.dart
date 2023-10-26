import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:consultant_orzu/pages/home/view/category/provider/category_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';

import 'package:consultant_orzu/utils/widgets/expansion_widget.dart';
import 'package:consultant_orzu/utils/widgets/main_product_container.dart';
import 'package:consultant_orzu/utils/widgets/search_button_field/search_button_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../about_product/about_product.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryProvider>(
      create: (context) => CategoryProvider(),
      child: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          var mainCategories = provider.mainCategories;
          var isLoading = provider.isLoading;
          var isAdding = provider.isAdding;
          var products = provider.products;

          return AddToCartAnimation(
            cartKey: provider.cartKey,
            height: 30,
            width: 30,
            opacity: 0.85,
            dragAnimation: const DragToCartAnimationOptions(rotation: true),
            jumpAnimation: const JumpAnimationOptions(),
            createAddToCartAnimation: (runAddToCartAnimation) {
              // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
              provider.runAddToCartAnimation = runAddToCartAnimation;
            },
            child: Scaffold(
              body: isLoading && !isAdding
                  ? CPIndicator()
                  : Column(
                      children: [
                        SearchButtonField(),
                        Stack(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                maxLines: 1,
                                text: TextSpan(
                                  text: 'all_category'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: provider.isCategory ? "" : "${provider.titleCategory}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Visibility(
                                visible: !provider.isCategory,
                                child: InkWell(
                                  onTap: () {
                                    provider.changeCategory = true;
                                  },
                                  child: Icon(Icons.clear_rounded),
                                ),
                              ),
                            ),
                          ],
                        ).paddingOnly(left: 8, right: 8, top: 8),
                        Expanded(
                          child: provider.isCategory
                              ? ListView(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: Get.height * 0.08,
                                  ),
                                  children: [
                                    for (var category in mainCategories)
                                      ExpansionWidget(
                                        category: category,
                                      ),
                                  ],
                                )
                              : RefreshIndicator(
                                  color: HexToColor.mainColor,
                                  onRefresh: () async {
                                    await provider.getProducts("${provider.slug1}");
                                  },
                                  child: GridView.builder(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      left: 11,
                                      right: 11,
                                      bottom: Get.height * 0.08,
                                    ),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: products.length == 0 ? 1 : 3,
                                      crossAxisSpacing: 0.1,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount: products.length == 0
                                        ? 1
                                        : isAdding
                                            ? products.length + 1
                                            : products.length,
                                    controller: provider.scrollController,
                                    itemBuilder: (BuildContext context, int index) {
                                      return products.length == 0
                                          ? Center(
                                              child: SvgPicture.asset(
                                                "assets/images/empty_history.svg",
                                                height: Get.height * 0.3,
                                              ),
                                            )
                                          : isAdding && (products.length == index)
                                              ? Center(
                                                  child: SizedBox.square(
                                                    dimension: 100,
                                                    child: CircularProgressIndicator(
                                                      color: HexToColor.mainColor,
                                                    ).marginAll(20),
                                                  ),
                                                )
                                              : MainProductContainer(
                                                  product: products[index],
                                                  onAddCalc: (widgetKey) {
                                                    provider.listClick(widgetKey);
                                                  },
                                                  onPressed: () {
                                                    Get.to(
                                                      () => AboutProduct(
                                                        slug: products[index]['slug'],
                                                      ),
                                                    );
                                                  },
                                                );
                                    },
                                  ),
                                ),
                        ),
                        AddToCartIcon(
                          key: provider.cartKey,
                          icon: Icon(Icons.shopping_cart, size: 0.0),
                          badgeOptions: const BadgeOptions(
                            active: true,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
