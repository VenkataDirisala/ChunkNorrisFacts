class ChucknorrisResponse {
  ChucknorrisResponse({
    this.categories,
    this.created_at,
    this.icon_url,
    this.id,
    this.updated_at,
    this.url,
    this.value,
  });

  String id;
  String url;
  String value;
  String updated_at;
  String created_at;
  String icon_url;
  List<String> categories;

  ChucknorrisResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    url = json['url'] as String;
    value = json['value'] as String;
    updated_at = json['updated_at'] as String;
    created_at = json['created_at'] as String;
    icon_url = json['icon_url'] as String;
    if (json['categories'] != null) {
      categories = <String>[];
      json['categories'].forEach((dynamic category) {
        categories.add(category);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['value'] = value;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    data['icon_url'] = icon_url;
    if (categories != null) {
      data['categories'] = categories;
    }
    return data;
  }
}
