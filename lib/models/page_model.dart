// هذا الكلاس يمثل الصفحة التعليمية ويحتوي على قائمة مدمجة من عناصر List<ItemModel>

import 'item_model.dart';

class PageModel {
  final String id;
  final int pageNumber;
  final List<ItemModel> items;

  PageModel({required this.id, required this.pageNumber, required this.items});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return PageModel(
      id: json['id'] ?? '',
      pageNumber: json['pageNumber'] ?? 0,
      items: rawItems
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
