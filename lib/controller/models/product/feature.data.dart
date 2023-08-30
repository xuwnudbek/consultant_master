class FeatureData {
  String group_id;
  String group_title_uz;
  String group_title_uzc;
  String group_title_ru;
  String feature_id;
  String feature_name_uz;
  String feature_name_uzc;
  String feature_name_ru;
  String is_view;
  String is_name;

  FeatureData({
    required this.group_id,
    required this.group_title_uz,
    required this.group_title_uzc,
    required this.group_title_ru,
    required this.feature_id,
    required this.feature_name_uz,
    required this.feature_name_uzc,
    required this.feature_name_ru,
    required this.is_view,
    required this.is_name,
  });

  factory FeatureData.fromMap(Map<String, dynamic> map) {
    return FeatureData(
      group_id: map["group_id"],
      group_title_uz: map["group_title_uz"],
      group_title_uzc: map["group_title_uzc"],
      group_title_ru: map["group_title_ru"],
      feature_id: map["feature_id"],
      feature_name_uz: map["feature_name_uz"],
      feature_name_uzc: map["feature_name_uzc"],
      feature_name_ru: map["feature_name_ru"],
      is_view: map["is_view"],
      is_name: map["is_name"],
    );
  }
}
