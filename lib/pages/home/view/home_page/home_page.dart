import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/controller/models/product/product.dart';
import 'package:consultant_orzu/pages/about_product/about_product.dart';
import 'package:consultant_orzu/pages/discount_page/discount_page.dart';
import 'package:consultant_orzu/pages/home/view/home_page/provider/home_page_provider.dart';
import 'package:consultant_orzu/utils/widgets/carousel_slider_indicator.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:consultant_orzu/utils/widgets/main_product_container.dart';
import 'package:consultant_orzu/utils/widgets/search_button_field/search_button_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context) => HomePageProvider(),
      child: Consumer<HomePageProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SearchButtonField(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "axsii".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CaruselSlider(provider.carusel),
                  //Discount Products
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "discount+gift".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Loader
                  Visibility(
                    visible: provider.isLoading,
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 1 / 6),
                      child: Center(child: CPIndicator()),
                    ),
                  ),
                  //Discount Products
                  Visibility(
                    visible: !provider.isLoading && provider.discounts.isNotEmpty,
                    child: Wrap(
                      runAlignment: WrapAlignment.spaceEvenly,
                      children: [
                        ...provider.discounts.map((product) {
                          return MainProductContainer(
                            width: Get.width * 0.3,
                            product: product,
                            onAddCalc: () {},
                            onPressed: () {
                              Get.to(() => AboutProduct(slug: product['slug']), transition: Transition.rightToLeft);
                            },
                          );
                        })
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CaruselSlider extends StatelessWidget {
  CaruselSlider(this.carusel);

  List carusel;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CaruselSliderProvider(),
      child: Consumer<CaruselSliderProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 10),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeIn,
                  onPageChanged: (index, reason) {
                    provider.onSlide(index);
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: carusel.map((discount) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => DiscountPage(id: discount['id']), transition: Transition.rightToLeft);
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                // colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                                image: NetworkImage(HttpService.images + discount['image']),
                                // AssetImage(i),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment(-0.7, 0),
                          //   child: SizedBox(
                          //     width: Get.width * 0.4,
                          //     child: Text(
                          //       "${discount['corusel_text']}",
                          //       style: Get.textTheme.titleLarge!.copyWith(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //e45454 which color => 0xffe45454
                        ],
                      ));
                }).toList(),
              ),
              CarouselSliderIndicator(
                position: provider.itemIndicator,
                length: carusel.length,
                list: carusel,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CaruselSliderProvider extends ChangeNotifier {
  int itemIndicator = 0;

  onSlide(value) {
    itemIndicator = value;
    notifyListeners();
  }
}
