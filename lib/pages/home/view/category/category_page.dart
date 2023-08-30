import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:consultant_orzu/pages/home/view/category/provider/category_provider.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';

import 'package:consultant_orzu/utils/widgets/expansion_widget.dart';
import 'package:consultant_orzu/utils/widgets/main_product_container.dart';
import 'package:consultant_orzu/utils/widgets/search_button_field/search_button_field.dart';
import 'package:flutter/material.dart';

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
              body: isLoading
                  ? CPIndicator()
                  : Column(
                      children: [
                        SearchButtonField(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
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
                              Visibility(
                                visible: !provider.isCategory,
                                child: InkWell(
                                  onTap: () {
                                    provider.changeCategory = true;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.clear_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                              : GridView.builder(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 11,
                                    right: 11,
                                    bottom: Get.height * 0.08,
                                  ),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0.1,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return MainProductContainer(
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
