class Brand {
  int id;
  int brandId;
  String name;

  Brand({
    required this.id,
    required this.brandId,
    required this.name,
  });

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map["id"],
      brandId: map["brand_id"],
      name: map["name"],
    );
  }
}
