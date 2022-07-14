class RecipeModel {
  RecipeModel({
      String? title,
      String? description,
      String? uri,
      String? asset,}){
    _title = title;
    _description = description;
    _asset = asset;
    _uri = uri;
}

  String? _title;
  String? _description;
  String? _asset;
  String? _uri;
RecipeModel copyWith({  String? title,
  String? description,
  String? asset,
}) => RecipeModel(  title: title ?? _title,
  description: description ?? _description,
  asset: asset ?? _asset,
);
  String? get title => _title;
  String? get description => _description;
  String? get asset => _asset;
  String? get uri => _uri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['asset'] = _asset;
    return map;
  }

}
