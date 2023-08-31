import 'package:consultant_orzu/controller/models/category/brand.dart';
import 'package:consultant_orzu/controller/models/category/category.dart';
import 'package:consultant_orzu/controller/models/category/sub_category.dart';
import 'package:consultant_orzu/pages/home/view/category/provider/category_provider.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExpansionWidget extends StatefulWidget {
  ExpansionWidget({
    super.key,
    required this.category,
  });
  Category category;

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  ExpansionTileController expansionTileController = ExpansionTileController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: shadowContainer(),
          ),
          child: ExpansionTile(
            key: Key(widget.category.id.toString()),
            iconColor: HexToColor.greenColor,
            textColor: HexToColor.blackColor,
            collapsedIconColor: HexToColor.mainColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
            initiallyExpanded: widget.category.id.toString() == provider.selectedCategory,
            leading: SvgPicture.network(
              widget.category.image!,
              height: 21.sp,
              width: 21.sp,
              // color: HexToColor.mainColor,
            ),
            onExpansionChanged: (value) {
              provider.onChanged();
              print(widget.category.id.toString() == provider.selectedCategory);
              provider.selectedCategory = value ? widget.category.id.toString() : null;
              if (value && widget.category.subCategories.length == 0) {
                // provider.onSelectCategory(breadCrumbs: "/${category.titleUz}");
              }
            },
            title: Text(
              widget.category.titleUz,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.8.sp),
            ),
            children: widget.category.subCategories.map<Widget>((e) {
              return subCategoryTile(
                e,
                "/${widget.category.titleUz}",
                onPressed: provider.onSelectCategory,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget subCategoryTile(
    SubCategory subCategory,
    String breadCrump, {
    required Function onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: ExpansionTile(
        iconColor: HexToColor.mainColor,
        textColor: HexToColor.mainColor,
        collapsedTextColor: Colors.grey.shade700,
        collapsedIconColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
        onExpansionChanged: (value) {
          if (value && subCategory.brands.length == 0) {
            onPressed(
              breadCrumbs: "$breadCrump/${subCategory.titleUz}",
              slug: subCategory.slug,
            );
          }
        },
        title: Text(
          subCategory.titleUz,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.8.sp),
        ),
        children: subCategory.brands.map<Widget>((e) {
          return brandTile(
            e,
            onPressed: () => onPressed(
              breadCrumbs: "$breadCrump/${subCategory.titleUz}/${e.name}",
              slug: subCategory.slug,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget brandTile(
    Brand brand, {
    required Function onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: ListTile(
        onTap: () => onPressed(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
        dense: true,
        title: Text(
          brand.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.8.sp),
        ),
      ),
    );
  }
}
