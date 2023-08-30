import 'package:consultant_orzu/controller/hive/hive.dart';
import 'package:consultant_orzu/pages/about_product/about_product.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/widgets/main_snackbars.dart';
import 'package:consultant_orzu/utils/widgets/search_button_field/provider/search_button_field_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class SearchButtonField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchButtonFieldProvider>(
      create: (context) => SearchButtonFieldProvider(),
      builder: (context, snapshot) {
        return Consumer<SearchButtonFieldProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: SearchField(
                onSearchTextChanged: (p0) {
                  provider.getSearchProducts(p0);
                },
                textInputAction: TextInputAction.search,
                controller: provider.searchController,
                itemHeight: 90,
                searchStyle: Get.textTheme.bodyLarge,
                searchInputDecoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      provider.clear();
                    },
                    icon: Icon(Icons.clear, color: Colors.grey),
                  ),
                  hintText: "search".tr,
                  hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey.shade500),
                  contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                  fillColor: HexToColor.greyTextFieldColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                suggestions: [
                  if (provider.products.isEmpty && provider.searchController.text.isNotEmpty && !provider.isLoading)
                    SearchFieldListItem(
                      "s",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "no_result".tr,
                            style: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ...provider.products.map(
                    (e) => SearchFieldListItem(
                      "${e['title_${HiveService.get("language")}']}",
                      child: SearchProductTile(product: e),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SearchProductTile extends StatelessWidget {
  const SearchProductTile({super.key, required this.product});

  final Map product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => AboutProduct(slug: product['slug']), transition: Transition.rightToLeft);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      tileColor: HexToColor.greyTextFieldColor,
      leading: Image.network(
        product['image'],
        fit: BoxFit.contain,
        width: 100,
      ),
      title: Text(
        product['title_uz'],
        maxLines: 2,
        style: Get.textTheme.bodyLarge,
      ),
      splashColor: HexToColor.greyTextFieldColor.withOpacity(.7),
    );
  }
}
