import 'package:consultant_orzu/controller/models/category/brand.dart';

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
      titleUz: map["title_uz"],
      titleUzc: map["title_uzc"],
      titleRu: map["title_ru"],
      image: map["image"],
      type: map["type"],
      slug: map["slug"],
      brands: map["brands"].map((e) => Brand.fromMap(e)).toList(),
    );
  }
}

/*
  "id": 7,
  "title_uz": "asdqasd",
  "title_uzc": "qdasdsa",
  "title_ru": "asdasdasd",
  "image": "https://app.orzugrand.uz/storage/uploads/categories/1681715924W9nFebHtOaTMxXq6.jpeg",
  "type": 2,
  "slug": "samsung-televizorlari-1",
*/