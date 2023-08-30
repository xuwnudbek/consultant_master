class OtherProduct {
  int id;
  int category_id;
  String slug;
  String article;
  String title_uz;
  String title_uzc;
  String title_ru;
  String short_description_uz;
  String short_description_uzc;
  String short_description_ru;
  var price;
  int discount_price;
  var monthly_pay;
  var is_discount;
  List badges;
  List tabs;
  String image;

  OtherProduct({
    required this.article,
    required this.badges,
    required this.category_id,
    required this.discount_price,
    required this.id,
    required this.image,
    required this.is_discount,
    required this.monthly_pay,
    required this.price,
    required this.short_description_ru,
    required this.short_description_uz,
    required this.short_description_uzc,
    required this.slug,
    required this.tabs,
    required this.title_ru,
    required this.title_uz,
    required this.title_uzc,
  });

  factory OtherProduct.fromMap(Map<String, dynamic> map) {
    return OtherProduct(
      article: map["article"],
      badges: map["badges"],
      category_id: map["category_id"],
      discount_price: map["discount_price"],
      id: map["id"],
      image: map["image"],
      is_discount: map["is_discount"],
      monthly_pay: map["monthly_pay"],
      price: map["price"],
      short_description_ru: map["short_description_ru"],
      short_description_uz: map["short_description_uz"],
      short_description_uzc: map["short_description_uzc"],
      slug: map["slug"],
      tabs: map["tabs"],
      title_ru: map["title_ru"],
      title_uz: map["title_uz"],
      title_uzc: map["title_uzc"],
    );
  }
}
