// هذا الكلاس يمثل الوحدة ويحتوي على ترتيبها وقائمة الصفحات التابعة لها List<PageModel>

import 'page_model.dart';

class UnitModel {
  final String id;
  final String title;
  final int order;
  final String? filePath;
  final List<PageModel> pages;

  UnitModel({
    required this.id,
    required this.title,
    required this.order,
    this.filePath,
    this.pages = const [],
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    final rawPages = json['pages'] as List<dynamic>? ?? [];
    return UnitModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      filePath: json['file'] as String?,
      pages: rawPages
          .map((page) => PageModel.fromJson(page as Map<String, dynamic>))
          .toList(),
    );
  }
}
