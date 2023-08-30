import 'package:consultant_orzu/controller/models/product/feature.data.dart';

class Feature {
  int family_id;
  String family_title_uz;
  String family_title_uzc;
  String family_title_ru;
  List<FeatureData> data;

  Feature({
    required this.family_id,
    required this.family_title_uz,
    required this.family_title_uzc,
    required this.family_title_ru,
    required this.data,
  });

  factory Feature.fromMap(Map<String, dynamic> map) {
    return Feature(
      family_id: map["family_id"],
      family_title_uz: map["family_title_uz"],
      family_title_uzc: map["family_title_uzc"],
      family_title_ru: map["family_title_ru"],
      data: map["data"],
    );
  }
}
