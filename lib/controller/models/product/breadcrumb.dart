class Breadcrumb {
  String name_uz;
  String name_uzc;
  String name_ru;
  String slug;

  Breadcrumb({
    required this.name_ru,
    required this.name_uz,
    required this.name_uzc,
    required this.slug,
  });

  factory Breadcrumb.fromMap(Map<String, dynamic> map) {
    return Breadcrumb(
      name_ru: map["name_ru"],
      name_uz: map["name_uz"],
      name_uzc: map["name_uzc"],
      slug: map["slug"],
    );
  }
}


/**
breadcrumbs": [
  {
      "name_uz": "Samsung sasd",
      "name_uzc": "Samsung asd",
      "name_ru": "Samsung xcas",
      "slug": "samsung-sasd"
  },
  {
      "name_uz": "Samsung televizorlari jinipi",
      "name_uzc": "Samsung televizorlari jinipi",
      "name_ru": "Samsung televizorlari jinipi",
      "slug": "samsung-televizorlari-jinipi"
  },
  {
      "name_uz": "Смартфонs Xiaomi Redmi Note 10 Pro 128GB Glacier Blue",
      "name_uzc": "Смартфонs Xiaomi Redmi Note 10 Pro 128GB Glacier Blue",
      "name_ru": "Смартфонs Xiaomi Redmi Note 10 Pro 128GB Glacier Blue",
      "slug": "smartfons-xiaomi-redmi-note-10-pro-128gb-glacier-blue"
  }
]
 */
