import 'package:consultant_orzu/controller/models/product/image.dart';
import 'package:get/get.dart';

class Product {
  final int? id;
  final int categoryId;
  final String? slug;
  final String article;
  final String titleUz;
  final String titleUzc;
  final String titleRu;
  final String? shortDescriptionUz;
  final String? shortDescriptionUzc;
  final String? shortDescriptionRu;
  var price;
  var discountPrice;
  var monthlyPay;
  var isDiscount;
  var images;
  var image;

  Product({
    required this.id,
    required this.categoryId,
    required this.slug,
    required this.article,
    required this.titleUz,
    required this.titleUzc,
    required this.titleRu,
    this.shortDescriptionUz,
    this.shortDescriptionUzc,
    this.shortDescriptionRu,
    required this.price,
    required this.discountPrice,
    this.monthlyPay,
    required this.isDiscount,
    required this.images,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      categoryId: map['category_id'],
      slug: map['slug'],
      article: map['article'],
      titleUz: map['title_${Get.locale!.languageCode}'],
      titleUzc: map['title_uzc'],
      titleRu: map['title_ru'],
      shortDescriptionUz: map['short_description_${Get.locale!.languageCode}'],
      shortDescriptionUzc: map['short_description_uzc'],
      shortDescriptionRu: map['short_description_ru'],
      price: map['price'],
      discountPrice: map['discount_price'],
      monthlyPay: map['monthly_pay'],
      isDiscount: map['is_discount'],
      image: map['image'] ?? null,
      images: map['images'] != null
          ? map['images']
              .map(
                (e) => ImgX(id: e['id'], image: e['image'], isMain: e['isMain']),
              )
              .toList()
          : [],
    );
  }
}
