import 'package:consultant_orzu/pages/about_cart/provider/about_cart_provider.dart';
import 'package:consultant_orzu/utils/widgets/product_container/product_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AboutCart extends StatelessWidget {
  AboutCart({super.key, this.sale = const {}});

  Map sale;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AboutCartProvider>(
      create: (context) => AboutCartProvider(),
      child: Consumer<AboutCartProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            centerTitle: true,
            title: Text(
              "products".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 16, /* bottom: 16*/
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...sale['products'].map(
                  (product) => ProductContainer(
                    canChangeCount: false,
                    canDelete: false,
                    product: product,
                    onDelete: () {
                      // provider.onDeleteProduct(product);
                    },
                    onChangeCount: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
