

import 'package:technical_test/data/details/model/chucknorris_response.dart';

class ChucknorrisDto {
  ChucknorrisDto({
    this.categories,
    this.createdTime,
    this.iconUrl,
    this.id,
    this.updatedTime,
    this.url,
    this.description,
    this.order,
  });

  String id;
  String url;
  int order;
  String description;
  DateTime updatedTime;
  DateTime createdTime;
  String iconUrl;
  List<String> categories;

  ChucknorrisDto.fromResponse(ChucknorrisResponse response, int order) {
    id = response.id;
    url = response.url;
    iconUrl = response.icon_url;
    categories = response.categories;
    description = response.value;
    createdTime = DateTime.parse(response.created_at);
    updatedTime = DateTime.parse(response.updated_at);
    this.order = order;
  }

  @override
  String toString() {
    return 'ChucknorrisDto{id: $id, url: $url, description: $description, updatedTime: $updatedTime, createdTime: $createdTime, iconUrl: $iconUrl, categories: $categories, order: $order';
  }
}
