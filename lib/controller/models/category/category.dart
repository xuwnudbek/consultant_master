import 'package:consultant_orzu/controller/models/category/sub_category.dart';

class Category {
  int id;
  String titleUz;
  String titleUzc;
  String titleRu;
  String? image;
  int type;
  String slug;
  var parent = null;
  List subCategories = [];

  Category({
    required this.id,
    required this.titleUz,
    required this.titleUzc,
    required this.titleRu,
    required this.image,
    required this.type,
    required this.slug,
    this.parent,
    required this.subCategories,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map["id"],
      titleUz: map["title_uz"],
      titleUzc: map["title_uzc"],
      titleRu: map["title_ru"],
      image: map["image"],
      type: map["type"],
      slug: map["slug"],
      subCategories:
          map['children'].map((e) => SubCategory.fromMap(e)).toList(),
    );
  }
}

/*
  "id": 2,
  "title_uz": "Samsung televizorlari",
  "title_uzc": "Samsung televizorlari",
  "title_ru": "Samsung televizorlari",
  "image": "https://app.orzugrand.uz/storage/uploads/categories/1680085655.jpeg",
  "type": 1,
  "slug": "samsung-televizorlari2",
  "parent": null,
*/