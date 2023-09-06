import 'package:consultant_orzu/controller/models/category/brand.dart';
import 'package:get/get.dart';

class SubCategory {
  int id;
  String titleUz;
  String titleUzc;
  String titleRu;
  String? image;
  int type;
  String slug;
  List brands = [];

  SubCategory({
    required this.id,
    required this.titleUz,
    required this.titleUzc,
    required this.titleRu,
    required this.image,
    required this.type,
    required this.slug,
    required this.brands,
  });

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map["id"],
      titleUz: map["title_${Get.locale!.languageCode}"],
      titleUzc: map["title_uzc"],
      titleRu: map["title_ru"],
      image: map["image"],
      type: map["type"],
      slug: map["slug"],
      brands: map["brands"].map((e) => Brand.fromMap(e)).toList(),
    );
  }
}
